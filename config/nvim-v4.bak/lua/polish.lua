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

vim.api.nvim_create_augroup(bash['group'], {
  clear = true,
})
empty_file_template(bash['group'], bash['pattern'], {
  '#!/bin/bash'
})

vim.api.nvim_create_augroup(php['group'], {
  clear = true,
})
empty_file_template(php['group'], '*Test.php', {
  '<?php',
  '',
  'namespace CoreReturns;',
  '',
  'use Tests\\Feature\\TestCase;',
  '',
  'class TestClass extends TestCase',
  '{',
  '    ',
  '}',
})
empty_file_template(php['group'], php['pattern'], {
  '<?php',
  '',
  '',
})

vim.api.nvim_create_augroup(vue['group'], {
  clear = true,
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
