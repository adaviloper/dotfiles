local get_target_node = require('helpers.treesitter').get_target_node
local parse_query_for_capture = require('helpers.treesitter').parse_query_for_capture

local get_above_assignment = function ()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { pos[1] - 1, pos[2] })
  vim.cmd('norm $')
  --- @type TSNode|nil {node}
  local node = get_target_node('lexical_declaration')

  if node ~= nil then
    local assignment_query = [[
(lexical_declaration
  (variable_declarator
    name: (identifier) @var
    ) @vd
  ) @ld
]]
    return parse_query_for_capture(node, assignment_query, 'var')[1]
  end

 node = get_target_node('expression_statement')

  if node == nil then
    vim.notify('expression_statement not found')
    return nil
  end

  local assignment_query = [[
(expression_statement
  (assignment_expression
    left: (identifier) @var
    )
  )
]]
  return parse_query_for_capture(node, assignment_query, 'var')[1]
end

return
  {
  },
  {
    s(
      'dml',
      fmta(
        [[console.log('<location>'<cursor>);]],
        {
          location = f(
            function ()
              local pos = vim.api.nvim_win_get_cursor(0)

              return vim.fn.expand('%:t') .. ':' .. pos[1]
            end
          ),
          cursor = sn(
            1,
            {
              d(1,
                function ()
                  local pos = vim.api.nvim_win_get_cursor(0)
                  local prev_line = vim.api.nvim_buf_get_lines(0, pos[1] - 2, pos[1] - 1, false)

                  if prev_line[1] and vim.trim(prev_line[1]) == '' then
                    return sn(nil, {
                      i(1, '')
                    })
                  end

                  local target_variable = get_above_assignment()
                  if target_variable == nil then
                    return sn(nil, {
                      i(1, '')
                    })
                  end

                  vim.api.nvim_win_set_cursor(0, pos)

                  if target_variable ~= nil then
                    return sn(1,
                      {
                        t(', '),
                        t(vim.trim(target_variable) .. ''),
                      }
                    )
                  end
                end
              )
            }
          ),
        }
      )
    )
  }


