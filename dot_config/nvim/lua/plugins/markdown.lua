return {
  {
    "OXY2DEV/markview.nvim",
    -- lazy = false,      -- Recommended
    ft = "markdown", -- If you decide to lazy-load anyway
    dependencies = {
      -- You will not need this if you installed the
      -- parsers manually
      -- Or if the parsers are in your $RUNTIMEPATH
      "nvim-treesitter/nvim-treesitter",

      "nvim-tree/nvim-web-devicons"
    },
    config = function ()
      local markview = require('markview')
      local presets = require('markview.presets')

      markview.setup({
        heading = presets.headings.glow_labels,
        preview = {
          modes = { 'i', 'n' },
          -- Override markview's default conceallevel of 3 so obsidian.nvim's UI keeps working
          callbacks = {
            on_attach = function (_, wins)
              for _, win in ipairs(wins) do vim.wo[win].conceallevel = 2 end
            end,
            on_enable = function (_, wins)
              for _, win in ipairs(wins) do vim.wo[win].conceallevel = 2 end
            end,
            on_mode_change = function (_, wins, mode)
              for _, win in ipairs(wins) do
                vim.wo[win].conceallevel = vim.list_contains({ 'i', 'n' }, mode) and 2 or 0
              end
            end,
          },
          ignore = {
            buftypes = { "nofile", "nowrite", "quickfix", "terminal", "prompt" },
          },
        }
      })
    end,
  },
  {
    "yousefhadder/markdown-plus.nvim",
    ft = "markdown",
    opts = {
      -- Your custom configuration here
    },
  }
}
