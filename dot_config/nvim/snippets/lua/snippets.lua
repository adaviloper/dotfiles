return
  {
    s(
      "snip",
      fmta(
        [=[
        s(
          {
            trig = "<trigger>",
          },
          fmta(
            [[
            <template>
            ]],
            {
              <args>
            }
          )
        ),
      ]=],
        {
          trigger = i(1, "trigger"),
          template = i(2, "body"),
          args = i(3, ""),
        }
      )
    ),

    s(
      {
        trig = "keybinding"
      },
      fmta(
        [=[
        ["<key>"] = <val>,
        ]=],
        {
          key = i(1, ''),
          val = c(2, {
            sn(
              nil,
              fmta(
                [[
                { "<rhs>", desc = "<desc>" }
                ]],
                {
                  rhs = i(1, ''),
                  desc = i(2, ''),
                }
              )
            ),
            sn(
              nil,
              fmta(
                [[
                {
                  function()
                    <body>
                  end, 
                  desc = "<desc>",
                }
                ]],
                {
                  body = i(1, ''),
                  desc = i(2, ''),
                }
              )
            ),
          })
        }
      )
    )
  },
  {
  }
