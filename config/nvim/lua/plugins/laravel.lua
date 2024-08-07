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
  end,
  config = true,
}
