return {
  "mizlan/iswap.nvim",
  lazy = false,
  config = function(first, second, third)
    require("iswap").setup {
      move_cursor = true,
    }
  end,
}
