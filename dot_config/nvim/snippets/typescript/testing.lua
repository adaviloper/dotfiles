return
  {
    s(
      'describe',
      fmta(
        [[
          describe('<description>', () =>> {
            <cursor>
          });
        ]],
        {
          description = i(1),
          cursor = i(2),
        }
      )
    ),
    s(
      'test',
      fmta(
        [[
          it('should <description>', () =>> {
            <body>
          });
        ]],
        {
          description = i(1),
          body = i(2),
        }
      )
    ),
  },
  {
  }
