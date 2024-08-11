return
  {
    s(
      'cml',
      fmt(
        [[console.{}('typescript', {});]],
        {
          c(1, { t('log'), t('error'), t('table') }),
          i(2, ''),
        }
      )
    )
  },
  {}
