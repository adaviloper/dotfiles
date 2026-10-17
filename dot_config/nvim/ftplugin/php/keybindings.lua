local astrocore = require("astrocore")

astrocore.set_mappings({
  n = {
    ["<LocalLeader>ts"] = { "<cmd>ToggleSyntax<CR>", desc = "Toggle property access type" },

    -- Testing
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

    -- Laravel.nvim
    ["<Leader>fl"] = { name = "Laravel" },
    ["<Leader>fll"] = { "<cmd>Laravel artisan<CR>", desc = "Laravel picker" },
    ["<Leader>fla"] = { "<cmd>Laravel artisan<CR>", desc = "Laravel artisan commands" },
    ["<Leader>flr"] = { "<cmd>Laravel routes<CR>", desc = "Laravel artisan routes" },
    ['<Leader>flc'] = { "<cmd>Laravel commands<cr>", desc = "Laravel commands" },
    ['<Leader>flm'] = { "<cmd>Laravel make<cr>", desc = "Laravel routes" },

    -- Phpactor.nvim
    ['<LocalLeader>p'] = { name = "Phpactor.nvim mappings" },
    ['<LocalLeader>pc'] = { '<cmd>PhpactorContextMenu<cr>', desc = "Context Menu" },
    ['<LocalLeader>pt'] = { '<cmd>PhpactorTransform<cr>', desc = "Transform file" },

  },
  v = {
    ['<LocalLeader>xv'] = { '<cmd>Extract variable<cr>', desc = "Extract to a variable" },
  },
})
