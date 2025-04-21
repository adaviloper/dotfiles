return
  {
    s(
      'dml',
      fmt(
        [[console.{}('{}'{});]],
        {
          c(1, { t('log'), t('error'), t('table') }),
          f(
            function ()
              local line_number = vim.api.nvim_win_get_cursor(0)
              return vim.fn.expand('%:t') .. ':' .. line_number[1]
            end
          ),
          i(2, '')
        }
      )
    )
  },
  {}


