return {
  'andymass/vim-matchup',
  enabled = true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      matchup = {
        enable = true,
      }
    })
  end
}
