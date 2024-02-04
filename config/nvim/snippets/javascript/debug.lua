return
 ; gcmsg "$(git_commit_prefix) "; gpsup {
    s('cml',
      fmt(
        'console.{}("{}", {});',
        {
          c(1, {
            t('table'),
            t('log'),
            t('error'),
            t('warn'),
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
  {}
