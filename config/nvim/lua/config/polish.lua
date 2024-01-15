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
    ["laravel.*%.log"] = 'laravellog'
  },
}

-- Autocommands
local php_group = 'PHP Autocommands'
vim.api.nvim_create_augroup(php_group, {
  clear = true,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  group = php_group,
  pattern = '*.php',
  callback = function(event)
    vim.notify('hit')
    vim.api.nvim_buf_set_lines(
      event.buf,
      0,
      1,
      true,
      {
        '<?php',
        '',
        '',
      }
    )
    vim.cmd('G')
  end
})

