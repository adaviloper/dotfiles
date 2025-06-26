return {
  'jiaoshijie/undotree',
  dependencies = 'nvim-lua/plenary.nvim',
  enabled = true,
  config = function()
    require('undotree').setup()
  end,
}
