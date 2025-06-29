return {
  'rasulomaroff/reactive.nvim',
  config = function ()
    require('reactive').setup({
      builtin = {
        cursor = true,
        cursorline = false,
        modemsg = false,
      },
      load = { 'catppuccin-mocha-cursor', 'catppuccin-mocha-cursor' }
    })
  end
}
