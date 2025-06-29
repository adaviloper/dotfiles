return {
  'chentoast/marks.nvim',
  event = 'VeryLazy',
  config = function ()
      require('marks').setup({
        default_mappings = true,
        signs = true,
        -- mappings = {}
      })
  end
}
