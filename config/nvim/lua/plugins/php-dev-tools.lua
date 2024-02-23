return {
  'adaviloper/php-dev-tools.nvim',
  -- dir = '~/Code/php-dev-tools.nvim',
  ft = 'php',
  config = function ()
    require('php-dev-tools').setup()
  end,
}
