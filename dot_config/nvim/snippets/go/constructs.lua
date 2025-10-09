return
  {
    s(
      "erv",
      fmta(
        [[
        <var>, <err> := <func>(<args>)
        if <rep_err> != nil {
          return <ret_val>, <rep_err>
        }
        ]],
        {
          var = i(1, ''),
          err = i(2, 'err'),
          func = i(3, ''),
          args = i(4, ''),
          ret_val = i(5, '0'),
          rep_err = rep(2),
        }
      )
    )
  },
  {
  }
