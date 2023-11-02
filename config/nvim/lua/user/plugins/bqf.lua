return {
  'kevinhwang91/nvim-bqf',
  lazy = false,
  config = function ()
    require('bqf').setup({
      func_map = {
        open = 'o',
        openc = '<CR>',
      }
    })
  end
}
