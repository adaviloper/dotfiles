local payload_methods = { 'POST', 'PATCH', 'PUT', }

return
  {
    s(
      {
        trig = "request",
      },
      fmta(
        [[
        ###

        <method> {{<route>}}/<path>
        Authorization: Bearer {{M2M_AUTH_TOKEN}}
        <body>
        ]],
        {
          method = c(1, { t('GET'), t('POST'), t('PATCH'), t('PUT'), t('DELETE') }),
          route = i(2, ''),
          path = i(3, ''),
          body = d(
            4,
            function (args, parent, user_args)
              if vim.tbl_contains(payload_methods, args[1][1]) then
                return sn(
                  nil,
                  fmta(
                    [[
                    <empty>
                    {
                      "<key>": "<val>"
                    }
                    ]],
                    {
                      empty = t(''),
                      key = i(1, ''),
                      val = i(2, ''),
                    }
                  )
                )
              end
              return sn(nil, {i(1, '')})
            end,
            { 1 }
          )
        }
      )
    ),
  },
  {
  }
