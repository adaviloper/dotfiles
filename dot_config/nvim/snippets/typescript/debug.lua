local get_target_node = require('helpers.treesitter').get_target_node
local parse_query_for_capture = require('helpers.treesitter').parse_query_for_capture

local get_above_assignment = function ()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { pos[1] - 1, pos[2] })
  vim.cmd('norm $')
  --- @type TSNode|nil {node}
  local node = get_target_node('lexical_declaration')

  if node == nil then
    vim.notify('lexical_declaration not found')
    return nil
  end

    local assignment_query = [[
(lexical_declaration
  (variable_declarator
    name: (identifier) @var
    ) @vd
  ) @ld
]]
    return parse_query_for_capture(node, assignment_query, 'var')[1]
  end
return
  {
  },
  {
    s(
      'dml',
      fmt(
        [[console.log('{}'{});]],
        {
          f(
            function ()
              local pos = vim.api.nvim_win_get_cursor(0)

              return vim.fn.expand('%:t') .. ':' .. pos[1]
            end
          ),
          sn(
            1,
            {
              d(1,
                function ()
                  local pos = vim.api.nvim_win_get_cursor(0)
                  local prev_line = vim.api.nvim_buf_get_lines(0, pos[1] - 2, pos[1] - 1, false)

                  if prev_line[1] == '' then
                    vim.notify('empty prev line')
                    return sn(nil, {
                      i(1, '')
                    })
                  end

                  local target_variable = get_above_assignment()
                  if target_variable == nil then
                    vim.notify('empty prev line')
                    return sn(nil, {
                      i(1, '')
                    })
                  end
                  vim.notify(vim.inspect(target_variable))

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


