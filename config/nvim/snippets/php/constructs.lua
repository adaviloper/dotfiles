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
  },
  {
    s(
      'el ',
      fmt(
        [[
        else {{
            {}
        }}
        ]],
        {
          i(1, ''),
        }
      )
    ),
    s(
      'elif ',
      fmt(
        [[
        else if (${}) {{
            {}
        }}
        ]],
        {
          i(1, ''),
          i(2, ''),
        }
      )
    ),
    s(
      'if ',
      fmt(
        [[
        if (${}) {{
            {}
        }}
        ]],
        {
          i(1, ''),
          i(2, ''),
        }
      )
    ),
    s(
      'fore ',
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
    s(
      'match ',
      fmt(
        [[
        match (${}) {{
            {} => {},
            default => {}
        }}
        ]],
        {
          i(1, 'constraint'),
          i(2, 'case'),
          i(3, 'return_val'),
          i(4, 'default_return'),
        }
      )
    ),
    s(
      'try ',
      fmt(
        [[
        try {{
            {}
        }} catch (Throwable $exception) {{
            {}
        }}
        ]],
        {
          i(1, ''),
          i(2, ''),
        }
      )
    ),
  }
