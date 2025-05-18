return
  {
    s(
      'dml',
      fmt(
        [[console.log('{}'{});]],
        {
          f(
            function ()
              local filename = vim.fn.expand('%:t')
              local line_number = vim.api.nvim_win_get_cursor(0)
              return vim.fn.expand('%:t') .. ':' .. line_number[1]
            end
          ),
          i(0, '')
        }
      )
    )
  },
  {}

