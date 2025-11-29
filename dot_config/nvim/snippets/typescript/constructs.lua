local str_utils = require("helpers.str_utils")
return
  {
    s(
      "class",
      fmta(
        [[
        export class <class> {
          constructor(<args>) {
          }

          <stop>
        }
        ]],
        {
          class = f(function ()
            return str_utils.pascal(vim.fn.expand("%:t:r"))
          end),
          args = i(1, ''),
          stop = i(2, '')
        }
      )
    ),
    s(
      "comment",
      fmta(
        [[
        /**
         * <comment>
         */
        ]],
        {
          comment = i(1, ''),
        }
      )
    ),
    s(
      "keyBy",
      fmta(
        [[
        const <variable_name> = <array>.reduce((acc: Record<<string, <acc_type>>>, <item>) =>> {
          if (!acc[<rep_item>.<prop>]) {
            acc[<rep_item>.<rep_prop>] = <rep_item>;
          }

          return acc;
        }, {});
        ]],
        {
          variable_name = i(1, ''),
          array = i(2, ''),
          acc_type = i(3, ''),
          item = i(4, ''),
          prop = i(5, ''),
          rep_item = rep(4),
          rep_prop = rep(5),
        }
      )
    ),
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
