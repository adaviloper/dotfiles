return {
  "uga-rosa/ccc.nvim",
  enabled = false,
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
