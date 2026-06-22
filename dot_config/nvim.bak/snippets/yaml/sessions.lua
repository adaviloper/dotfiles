local str_utils = require "helpers.str_utils"
return
  {
    s(
      'workspace',
      fmta(
        [[
        session_name: <session_name>
        start_directory: "~/Code/<start_directory>"
        windows:
          - window_name: Backend
            panes:
              - shell_command:
                  - cmd: "c"
          - window_name: Frontend
            panes:
              - shell_command:
                  - cmd: "c"
          - window_name: Terminals
            layout: main-vertical
            panes:
              - shell_command:
                  - cmd: "c"
        ]],
        {
          session_name = f(function ()
            local file_name = vim.fn.expand('%:t:r')
            return str_utils.title_case(file_name)
          end),
          start_directory = i(1),
        }
      )
    )
  },
  {
  }
