return
  {
    s(
      {
        trig = "env",
      },
      fmta(
        [[
        {
          "$shared": {
          },

          "dev": {
            "<key>": "<value>"
          },

          "qa": {
          },

          "stage": {
          },

          "prod": {
          }
        }
        ]],
        {
          key = i(1, ''),
          value = i(2, ''),
        }
      )
    ),
  },
  {
  }
