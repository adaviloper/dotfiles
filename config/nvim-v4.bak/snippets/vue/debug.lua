return
    {
    s('cml',
      fmt(
        'console.{}("{}", {});',
        {
          c(1, {
            t('log'),
            t('error'),
            t('warn'),
            t('table'),
            t('info'),
          }),
          f(function (args)
            local filename = vim.fn.expand('%:t:r')
            local position = vim.fn.getcurpos(0)

            return filename .. ':' .. tostring(position[2])
          end),
          i(2, ''),
        }
      )
    ),
  },
  {

  }
