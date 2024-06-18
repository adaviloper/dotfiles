return {
  'jiaoshijie/undotree',
  dependencies = 'nvim-lua/plenary.nvim',
  enabled = false,
  config = function()
    require('undotree').setup()
  end,
}
