return {
  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim',
    }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
      require('render-markdown').setup({
        bullet = {
          -- Turn on / off list bullet rendering
          enabled = true,
          -- Replaces '-'|'+'|'*' of 'list_item'
          -- How deeply nested the list is determines the 'level'
          -- The 'level' is used to index into the array using a cycle
          -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
          icons = { '●', '○', '◆', '◇' },
          -- Highlight for the bullet icon
          highlight = 'Normal',
        },
      })
    end,
  },
  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown", -- or 'event = "VeryLazy"'
    opts = {
      -- configuration here or empty for defaults
    },
  }
}
