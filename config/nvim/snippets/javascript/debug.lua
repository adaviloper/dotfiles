return
  {
    s('clog',
      fmt(
        'console.log({});',
        {
          i(1, ''),
        }
      )
    ),
    s('cerr',
      fmt(
        'console.error({});',
        {
          i(1, ''),
        }
      )
    ),
  },
  {}
