return
  {
    s(
      {
        trig = "kvpair"
      },
      fmta(
        [[
        "<key>": <val>
        ]],
        {
          key = i(1, ''),
          val = c(2, {
            sn(
              nil,
              fmta(
                [[
                "<ins>"
                ]],
                {
                  ins = i(1, ''),
                }
              )
            ),
            i(nil, ''),
            t('true'),
            t('false'),
          })
        }
      )
    )
  },
  {
  }
