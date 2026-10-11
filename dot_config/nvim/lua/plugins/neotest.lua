return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
    "olimorris/neotest-phpunit",
    "marilari88/neotest-vitest",
  },
  config = function()
    -- Per-project container, set in the project's .nvim.lua (loaded via `exrc`):
    --   vim.g.neotest_phpunit = { service = "redwood_api", remote_path = "/var/www/html", user = nil }
    -- Projects without it fall back to the Sail wrapper.
    local function container()
      local project = vim.g.neotest_phpunit
      if not (project and project.service) then return nil end
      return {
        service = project.service,
        user = project.user,
        root = vim.fn.getcwd(),
        remote = project.remote_path or "/var/www/html",
      }
    end

    local function program()
      local c = container()
      if not c then return { vim.fn.expand("~/.config/bin/docker/sail-phpunit") } end

      local cmd = { "docker", "compose", "exec", "-T" }
      if c.user then vim.list_extend(cmd, { "--user", c.user }) end
      return vim.list_extend(cmd, { c.service, "php", "vendor/bin/phpunit" })
    end

    local function swap(str, from, to)
      return (str:gsub(vim.pesc(from), (to:gsub("%%", "%%%%"))))
    end

    local phpunit = require("neotest-phpunit")({
      phpunit_cmd = program,
    })

    -- neotest-phpunit ignores extra_args and has no container support, so patch the command ourselves
    local build_spec = phpunit.build_spec
    phpunit.build_spec = function(args)
      local spec = build_spec(args)
      if not spec then return spec end

      local prefix = #program()

      -- a group run spans the whole suite, so drop the position's path and --filter
      if args.extra_args and vim.tbl_contains(args.extra_args, "--group") then
        local command = vim.list_slice(spec.command, 1, prefix)
        for _, arg in ipairs(spec.command) do
          if type(arg) == "string" and vim.startswith(arg, "--log-junit=") then
            table.insert(command, arg)
          end
        end
        spec.command = command
        spec.context.group = true
      end

      if args.extra_args then vim.list_extend(spec.command, args.extra_args) end

      -- the container can't see host paths, so map them to the mount and log junit inside the project
      local c = container()
      if c then
        local id = vim.uv.os_getpid() .. "-" .. vim.fn.fnamemodify(spec.context.results_path, ":t")
        local junit = "storage/logs/neotest-" .. id .. ".xml"
        for i = prefix + 1, #spec.command do
          local arg = spec.command[i]
          if type(arg) == "string" then
            spec.command[i] = vim.startswith(arg, "--log-junit=")
              and ("--log-junit=" .. c.remote .. "/" .. junit)
              or swap(arg, c.root, c.remote)
          end
        end
        spec.context.container = { root = c.root, remote = c.remote, junit = c.root .. "/" .. junit }
      end

      return spec
    end

    local results = phpunit.results
    phpunit.results = function(spec, result, tree)
      -- copy the container's junit report to where neotest expects it, with host paths restored
      local c = spec.context.container
      if c and vim.uv.fs_stat(c.junit) then
        local report = table.concat(vim.fn.readfile(c.junit), "\n")
        vim.fn.writefile(vim.split(swap(report, c.remote, c.root), "\n"), spec.context.results_path)
        vim.uv.fs_unlink(c.junit)
      end

      -- neotest marks tests missing from the report as failed, so mark tests outside the group as skipped
      local test_results = results(spec, result, tree)
      if spec.context.group then
        for _, pos in tree:iter() do
          if pos.type == "test" and not test_results[pos.id] then
            test_results[pos.id] = { status = "skipped" }
          end
        end
      end
      return test_results
    end

    require("neotest").setup({
      adapters = {
        phpunit,

        require('neotest-vitest'){
          filter_dir = function (name, _, _)
            return name ~= 'node_modules'
          end
        },
      },
    })
  end
}
