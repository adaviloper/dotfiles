return
  {
  },
  {
    s(
      '#!',
      f(function ()
        local filename = vim.fn.expand('%:p')
        if filename ~= '' then
          -- Write the file to disk, then set executable permissions
          vim.cmd('silent write')
          vim.fn.setfperm(filename, 'rwxr-xr-x')
        end
        return '#!/bin/bash'
      end)
    )
  }
