-- This file is automatically ran last in the setup process and is a good place to configure
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here

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
local vue = {
  group = 'Vue Autocommands',
  pattern = '*.vue',
}

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
  '<script lang="ts" setup>',
  '',
  '</script>',
  '',
  '<style scoped>',
  '',
  '</style>',
})

