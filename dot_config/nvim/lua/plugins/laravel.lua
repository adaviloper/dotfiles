return {
  {
    'RicardoRamirezR/blade-nav.nvim'
  },
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "tpope/vim-dotenv",
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "kevinhwang91/promise-async",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    -- keys = {
    --   { "<leader>la", ":Laravel artisan<cr>" },
    --   { "<leader>lr", ":Laravel routes<cr>" },
    --   { "<leader>lm", ":Laravel related<cr>" },
    -- },

    event = { "VeryLazy" },
    opts = function (_, opts)
      opts.features = {
        route_info = {
          enable = true,
          position = "top",
        }
      }

      opts.environments = {
        definitions = {
          {
            name = "together",
            condition = {
              file_exists = { "docker-compose.yml" },
              executable = { "docker" },
            },
            commands = {
              compose = { "docker", "compose" },
              {
                commands = { "php", "composer" },
                docker = {
                  container = {
                    default = "together_api",
                  },
                  exec = { "docker", "compose", "exec", },
                },
              },
            },
          },
          {
            name = "redwood",
            condition = {
              file_exists = { "docker-compose.yml" },
              executable = { "docker" },
            },
            commands = {
              compose = { "docker", "compose" },
              {
                commands = { "php", "composer" },
                docker = {
                  container = {
                    default = "redwood_api",
                  },
                  exec = { "docker", "compose", "exec", },
                },
              },
            },
          },
        }
      }
    end,
  }
}
