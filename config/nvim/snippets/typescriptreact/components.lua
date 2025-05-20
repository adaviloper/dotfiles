local str_utils = require "helpers.str_utils"

return
  {
    s(
      'react',
      fmt(
        [[
          export default function {}() {{
            return (
              {}
            );
          }};
        ]],
        {
          f(function ()
            local file_name = vim.fn.expand('%:t:r')

            return str_utils.pascal(file_name)
          end),
          i(0),
        })
    )
  },
  {}
