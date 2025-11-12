return {
  'Wansmer/treesj',
  config = function ()
    require('treesj').setup({
      max_join_length = 1000,
    })
  end,
}
