return
  {
    s(
      { trig = "for([%w_]+)", regTrig = true },
      fmt([[
      for (${} = 0; ${} < {}; ${}++) {{
          {}
      }}
      ]],
        {
          d(1, function (_, snip)
            return sn(1, i(1, snip.captures[1]))
          end),
          rep(1),
          i(2, 'limit'),
          rep(1),
          i(3, ''),
        }
      )
    ),
    s(
      { trig = "fe([%w_]+)", regTrig = true },
      fmt([[
      foreach (${} as ${}{}) {{
          {}
      }}
      ]],
        {
          d(1, function (_, snip)
            return sn(1, i(1, snip.captures[1]))
          end),
          rep(1),
          i(2, ''),
          i(3, ''),
        }
      )
    ),
  },
  {

  }
