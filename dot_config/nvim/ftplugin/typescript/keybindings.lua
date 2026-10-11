local astrocore = require("astrocore")

astrocore.set_mappings({
  n = {
    ['<LocalLeader>ts'] = { "<cmd>ToggleSyntax<CR>", desc = "Toggle arrow function syntax" },

    ["<F4><F4>"] = {
      function() require("neotest").run.run_last() end,
      desc = "Rerun the previous test",
    },
    ["<F4>n"] = {
      function() require("neotest").run.run() end,
      desc = "Run nearest test",
    },
    ["<F4>f"] = {
      function() require("neotest").run.run(vim.fn.expand("%")) end,
      desc = "Test the entire file",
    },
    ["<F4>g"] = {
      function()
        local cmd = vim.fn.expand("~/.config/bin/docker/sail-phpunit")
        vim.system({ cmd, "--list-groups" }, { text = true }, function(out)
          vim.schedule(function()
            if out.code ~= 0 then
              vim.notify("Failed to list PHPUnit groups:\n" .. (out.stderr or ""), vim.log.levels.ERROR)
              return
            end

            local groups = {}
            for line in out.stdout:gmatch("[^\r\n]+") do
              local group = line:match("^%s*%-%s*(%S+)")
              if group and not vim.startswith(group, "__phpunit") then
                table.insert(groups, group)
              end
            end

            if #groups == 0 then
              vim.notify("No PHPUnit groups found", vim.log.levels.WARN)
              return
            end

            vim.ui.select(groups, { prompt = "PHPUnit group" }, function(group)
              if not group then return end
              require("neotest").run.run({
                suite = true,
                extra_args = { "--group", group },
              })
            end)
          end)
        end)
      end,
      desc = "Select a group to test",
    },

    ["<F4>w"] = {
      function ()
        -- neotest.watch reruns on save itself; vitest must stay in run mode (neotest-vitest adds --watch=false)
        require('neotest').watch.toggle(vim.fn.expand("%"))
        require('neotest').summary.toggle()
      end,
      desc = "Run Test watcher"
    }
  },
  v = {
    ['<LocalLeader>xv'] = { '<cmd>Extract variable<cr>', desc = "Extract to a variable" },
  },
})
