local get_target_node = require('helpers.treesitter').get_target_node
local parse_query_for_capture = require('helpers.treesitter').parse_query_for_capture
local in_nodes_condition = require('helpers.treesitter').in_nodes_condition

local get_above_assignment = function ()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { pos[1] - 1, pos[2] })
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
    params = vim.iter(parse_query_for_capture(node, assignment_query, 'var'))
    return params:join(', ')
  end
end

return
  -- Snippets
  {
    -- Public function
        s('ll',
        fmt(
        [[
        Log::{}('{} - {}');
        ]],
        {
          c(1, { t('info'), t('error'), t('warning') }),
          f(function ()
            local node = get_target_node('method_declaration')
            if not node then
              vim.notify('No target node found.')
              return
            end

            local method_name = nil
            local query = vim.treesitter.query.parse('php',  "[(method_declaration name: (_) @name)]")
            for _, capture in query:iter_captures(node, 0) do
              method_name = vim.treesitter.get_node_text(capture, 0)
            end

            if method_name ~= nil then
              return vim.fn.expand('%:t:r') .."#" .. method_name
            end

            return vim.fn.expand('%:t:r')
          end),
          i(2, ''),
        }
        )
        ),
  },
  -- Autosnippets
  {
    s({
      trig = 'dml',
      condition = in_nodes_condition({'method_declaration'}),
      show_condition = in_nodes_condition({'method_declaration'}),
    },
      fmt(
        [[
dd({}__METHOD__ . ':' . __LINE__);
    ]], {
          sn(
            1,
            {
              d(1, function ()
                local pos = vim.api.nvim_win_get_cursor(0)
                local prev_line = vim.api.nvim_buf_get_lines(0, pos[1] - 2, pos[1] - 1, false)
                if prev_line[1] == '' then
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
                      i(1, ''),
                      t(', '),
                    }
                  )
                end

                return sn(nil, {
                  i(1, '')
                })
              end)
            }
          ),
        })),
  }

