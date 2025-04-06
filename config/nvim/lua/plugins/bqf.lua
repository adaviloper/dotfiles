return {
  'kevinhwang91/nvim-bqf',
  enabled = true,
  config = function ()
    require('bqf').setup({
      func_map = {
        open = 'o',
        openc = '<CR>',
      }
    })
  end
}
