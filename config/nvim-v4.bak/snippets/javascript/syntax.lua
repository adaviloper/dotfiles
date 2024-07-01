return
  {
    s(
      { trig = "for([%w_]+)", regTrig = true },
      fmt([[
      for ({} = 0; {} < {}; {}++) {{
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
      else if ({}) {{
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
      if ({}) {{
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
      'try ',
      fmt(
        [[
      try {{
          {}
      }} catch (exception) {{
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
