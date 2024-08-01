return {
  'andymass/vim-matchup',
  enabled = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      matchup = {
        enable = true,
      }
    })
    vim.cmd([[let g:matchup_matchparen_offscreen = {'method': 'status_manual'}]])
  end
}
