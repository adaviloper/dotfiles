return {
  'adaviloper/php-dev-tools.nvim',
  ft = 'php',
  config = function ()
    require('php-dev-tools').setup()
  end,
}
