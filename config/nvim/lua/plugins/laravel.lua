return {
  "adalessa/laravel.nvim",
  branch = "feature/container",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
    "nvimtools/none-ls.nvim",
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
          name = "loop",
          condition = {
            file_exists = { "docker-compose.yml" },
            executable = { "docker" },
          },
          commands = {
            compose = { "docker", "compose" },
            {
              commands = { "php", "composer", "npm" },
              docker = {
                container = {
                  env = "APP_SERVICE",
                  default = "core",
                },
                exec = { "docker", "compose", "exec", "-it" },
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
                  default = "app",
                },
                exec = { "docker", "compose", "exec", "-it" },
              },
            },
          },
        },
      }
    }
  end,
}
