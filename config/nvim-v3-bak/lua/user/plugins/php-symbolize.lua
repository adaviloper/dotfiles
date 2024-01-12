return {
  'adaviloper/php-symbolize.nvim',
  event = 'VeryLazy',
  enabled = true,
  config = function ()
    require('php-symbolize').setup()
  end,
}
