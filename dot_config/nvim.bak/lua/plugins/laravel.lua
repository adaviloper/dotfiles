return {
  {
    'RicardoRamirezR/blade-nav.nvim'
  },
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
    },
    ft = { "php", "blade" },
    event = {
      "BufEnter composer.json",
    },
    keys = {
      { "<F12>ll", function() Laravel.pickers.laravel() end,              desc = "Laravel: Open Laravel Picker" },
      { "<c-g>",      function() Laravel.commands.run("view:finder") end,    desc = "Laravel: Open View Finder" },
      { "<F12>la", function() Laravel.commands.run("actions") end,              desc = "Laravel: Open Artisan Picker" },
      { "<F12>lt", function() Laravel.commands.run('tinker:select') end,        desc = "Laravel: Open Actions Picker" },
      { "<F12>lr", function() Laravel.pickers.routes() end,               desc = "Laravel: Open Routes Picker" },
      { "<F12>lh", function() Laravel.run("artisan docs") end,            desc = "Laravel: Open Documentation" },
      { "<F12>lm", function() Laravel.pickers.make() end,                 desc = "Laravel: Open Make Picker" },
      { "<F12>lc", function() Laravel.pickers.commands() end,             desc = "Laravel: Open Commands Picker" },
      { "<F12>lo", function() Laravel.pickers.resources() end,            desc = "Laravel: Open Resources Picker" },
      { "<F12>lp", function() Laravel.commands.run("command_center") end, desc = "Laravel: Open Command Center" },
      { "<F12>lu", function() Laravel.commands.run("hub") end,            desc = "Laravel Artisan hub" },
      {
        "gf",
        function()
          local ok, res = pcall(function()
            if Laravel.app("gf").cursorOnResource() then
              return "<cmd>lua Laravel.commands.run('gf')<cr>"
            end
          end)
          if not ok or not res then
            return "gf"
          end
          return res
        end,
        expr = true,
        noremap = true,
      },
    },

    opts = {
      features = {
        pickers = {
          enable = true,
          provider = "snacks",
        },
        route_info = {
          enable = true,
          position = "top",
        }
      },

      environments = {
        ask_on_boot = true,
        definitions = {
          {
            name = "together",
            map = {
              php = { "docker", "compose", "exec", "together_api", "php" },
              composer = { "docker", "compose", "exec", "together_api", "composer" },
            },
          },
          {
            name = "redwood",
            map = {
              php = { "docker", "compose", "exec", "redwood_api", "php" },
              composer = { "docker", "compose", "exec", "redwood_api", "composer" },
            },
          },
          { name = "local" },
        }
      },

      user_commands = {
      },

    },
  }
}
