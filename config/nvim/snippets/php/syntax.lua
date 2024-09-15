local get_target_node = require('helpers.treesitter').get_target_node
local parse_query_for_capture = require('helpers.treesitter').parse_query_for_capture

local P = function(variable)
  vim.notify(vim.inspect(variable))
end

local get_above_assignment = function ()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
  vim.cmd('norm $')
  --- @type TSNode|nil {node}
  local node = get_target_node('expression_statement')
  if node ~= nil then
    P(node:type())
  end

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

  local params = {}
  node = get_target_node({'anonymous_function_creation_expression'})
  if node then
    local assignment_query = [[
(_
  (formal_parameters
    (_ name: (variable_name) @var)
    )
  )
]]
    params = vim.iter(parse_query_for_capture(node, assignment_query, 'var')
    )
    return params:join(', ')
  end

  node = get_target_node({'method_declaration'})
  if node then
    local assignment_query = [[
(method_declaration
  (formal_parameters
    (_ name: (variable_name) @var)
    )
  )
]]
    params = vim.iter(parse_query_for_capture(node, assignment_query, 'var')
    )
    return params:join(', ')
  end

  node = get_target_node({'anonymous_function_creation_expression'})
  if node then
    local assignment_query = [[
(_
  (formal_parameters
    (_ name: (variable_name) @var)
    )
  )
]]
    params = vim.iter(parse_query_for_capture(node, assignment_query, 'var')
    )
    return params:join(', ')
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
                local target_variable = get_above_assignment()
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
