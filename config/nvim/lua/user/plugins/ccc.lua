return {
  "uga-rosa/ccc.nvim",
  ft = {
    'css',
    'html',
    'lua',
    'scss',
    'sass',
    'vue'
  },
  config = function ()
    require('ccc').setup()
  end,
}
