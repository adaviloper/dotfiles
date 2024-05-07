return {
  'adaviloper/php-dev-tools.nvim',
  -- dir = '~/Code/php-dev-tools.nvim',
  ft = 'php',
  config = function ()
    require('php-dev-tools').setup({
      test_utils = {
        {
          dir = '~/Code/loop-returns-app',
          cmd = './script/tests --filter',
          -- cmd = 'docker exec -it core vendor/bin/phpunit --filter',
        },
        {
          dir = '~/Code/figs-recycling-campaign/logistics',
          cmd = 'sail test --filter',
        },
      }
    })
  end,
}
