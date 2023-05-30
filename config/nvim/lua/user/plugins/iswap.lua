return {
  "mizlan/iswap.nvim",
  lazy = false,
  config = function()
    require("iswap").setup {
      move_cursor = true,
    }
  end,
}
