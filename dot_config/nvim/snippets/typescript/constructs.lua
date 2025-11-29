return
  {
    s(
      "c",
      fmta(
        [[
        const <var_name> = <definition>;
        ]],
        {
          var_name = i(1, ''),
          definition = i(2, ''),
        }
      )
    ),
    s(
      "l",
      fmta(
        [[
        let <var_name> = <definition>;
        ]],
        {
          var_name = i(1, ''),
          definition = i(2, ''),
        }
      )
    ),
    s(
      "v",
      fmta(
        [[
        var <var_name> = <definition>;
        ]],
        {
          var_name = i(1, ''),
          definition = i(2, ''),
        }
      )
    ),
    s("type",
      fmt(
        [[
        export type {type_name} = {definition};
        ]],
        {
          type_name = c(1, {
            i(nil, ''),
            fmt(
              [[
              {}<{}>
              ]],
              {
                i(1, ''),
                i(2, ''),
              }
            )
          }),
          definition = c(2, {
            i(nil, ''),
            fmta(
              [[
              {
                <cursor_end>
              }
              ]],
              {
                cursor_end = i(1, ''),
              }
            )
          }),
        }
      )
    ),
  },
  {
  }
