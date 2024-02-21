return {
  'rasulomaroff/reactive.nvim',
  config = function ()
    require('reactive').setup({
      builtin = {
        cursor = true,
        cursorline = false,
        modemsg = false,
      }
    })
  end
}
