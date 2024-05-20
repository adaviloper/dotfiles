-- This file is automatically ran last in the setup process and is a good place to configure
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
function P(item)
  vim.notify(vim.inspect(item))
end

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    -- foo = "fooscript",
    -- log = "json"
  },
  filename = {
    -- ["Foofile"] = "fooscript",
  },
  pattern = {
    -- ["~/%.config/foo/.*"] = "fooscript",
    ["laravel.*%.log"] = 'json'
  },
}

local empty_file_template = require("helpers.au").empty_file_template

-- Autocommands
local php = {
  group = 'PHP Autocommands',
  pattern = '*.php',
}
local bash = {
  group = 'Bash Autocommands',
  pattern = '*.sh',
}
local vue = {
  group = 'Vue Autocommands',
  pattern = '*.vue',
}

empty_file_template(bash['group'], bash['pattern'], {
  '#!/bin/bash'
})

empty_file_template(php['group'], php['pattern'], {
  '<?php',
  '',
  '',
})

empty_file_template(vue['group'], vue['pattern'], {
  '<template>',
  '  <div>',
  '',
  '  </div>',
  '</template>',
  '',
  '<script setup lang="ts">',
  '',
  '</script>',
  '',
  '<style lang="scss" scoped>',
  '',
  '</style>',
})

empty_file_template(php['group'], '*Test.php', {
  '<?php',
  '',
  'namespace CoreReturns;',
  '',
  'use PHPUnit\\Framework\\Attributes\\CoversClass;',
  'use PHPUnit\\Framework\\Attributes\\Group;',
  'use Tests\\Feature\\TestCase;',
  '',
  '#[CoversClass(), Group()]',
  'class TestClass extends TestCase',
  '{',
  '    ',
  '}',
})
