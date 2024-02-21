return {
  -- 'adaviloper/php-dev-tools.nvim',
  dir = '~/Code/php-dev-tools.nvim/',
  event = 'VeryLazy',
  enabled = true,
  config = function ()
    require('php-dev-tools').setup()
  end,
}
