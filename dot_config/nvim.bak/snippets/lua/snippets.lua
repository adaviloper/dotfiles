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
  },
  {
  }
