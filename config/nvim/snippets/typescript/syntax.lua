return
  {
    s(
      'var',
      fmt([[
      {} {} = {};
      ]],
        {
          c(1, { t('const'), t('let'), t('var') }),
          i(2, ''),
          i(0, ''),
        }
      )
    ),
    s(
      'inter',
      fmt([[
      interface {} {{
        {}: {};
      }};
      ]],
        {
          i(1, ''),
          i(2, ''),
          i(0, ''),
        }
      )
    ),
  },
  {}
