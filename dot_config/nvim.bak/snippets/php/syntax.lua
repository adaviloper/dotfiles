local get_target_node = require('helpers.treesitter').get_target_node
local parse_query_for_capture = require('helpers.treesitter').parse_query_for_capture

local get_variable_name = function ()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
  vim.cmd('norm $')
  --- @type TSNode|nil {node}
  local node = get_target_node('expression_statement')

  if node then
    local assignment_query = [[
  (expression_statement
    (assignment_expression
      left: (_) @var
      )
    ) @expression
]]
    return parse_query_for_capture(node, assignment_query, 'var')[1]
  end
end

return
  {},
  {
    s(
      'vtype',
        fmt(
        [[
        /** @var {} {} */
        ]],
        {
          i(1, ''),
          sn(
            2,
            {
              d(1, function ()
                local pos = vim.api.nvim_win_get_cursor(0)
                local target_line = vim.api.nvim_buf_get_lines(0, pos[1] + 0, pos[1] + 1, false)
                if target_line[1] == '' then
                  return sn(nil, {
                    i(1, '')
                  })
                end
                local target_variable = get_variable_name()
                vim.api.nvim_win_set_cursor(0, pos)

                if target_variable ~= nil then
                  return sn(1,
                    {
                      t(vim.trim(target_variable) .. ''),
                    }
                  )
                end

                return sn(nil, {
                  i(1, '')
                })
              end)
            }
          ),
        }
      )
    )
  }
