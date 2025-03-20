return {
  {
    'ccaglak/phptools.nvim',
    enabled = false,
  },
  {
    'adaviloper/php-dev-tools.nvim',
    -- dir = '~/Code/php-dev-tools.nvim',
    -- ft = 'php',
    event = 'VeryLazy',
    config = function ()
      require('php-dev-tools').setup({
        test_utils = {
          {
            dir = '~/Code/redwood',
            cmd = 'dart test',
            group_cmd = 'dock ./vendor/bin/phpunit --list-groups',
          },
        }
      })
    end,
  }
}
