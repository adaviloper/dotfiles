return {
  "mizlan/iswap.nvim",
  event = 'VeryLazy',
  config = function()
    require("iswap").setup {
      move_cursor = true,
    }
  end,
}
