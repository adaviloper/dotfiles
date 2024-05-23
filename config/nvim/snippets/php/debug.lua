local ts = vim.treesitter
local get_node_text = ts.get_node_text
local get_target_node = function(node_name)
  local node = vim.treesitter.get_node()

  while node ~= nil do
    if node:type() == node_name then
      return node
    end

    node = node:parent()
  end
end

local get_above_assignment = function ()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { pos[1] - 1, pos[2] })
  vim.cmd('norm $')
  --- @type TSNode|nil {node}
  local node = ts.get_node()

  if not node then
    vim.notify('No target node found.')
    return
  end

  local assignment_query = [[
  (expression_statement
    (assignment_expression
      left: (_) @var
      )
    ) @expression
]]
  local query = ts.query.parse('php', assignment_query)
  for i, match, _ in query:iter_captures(node, 0) do
    local name = query.captures[i]
    if name == 'var' then
      vim.api.nvim_win_set_cursor(0, pos)
      return get_node_text(match, 0)
    end
  end
end

return
  -- Snippets
  {
    -- Public function
    s('dml',
      fmt(
        [[
dd({}__METHOD__ . ':' . __LINE__);
    ]], {
          sn(
            1,
            {
              d(1, function (args)
                local pos = vim.api.nvim_win_get_cursor(0)
                local prev_line = vim.api.nvim_buf_get_lines(0, pos[1] - 2, pos[1] - 1, false)
                if prev_line[1] == '' then
                  return sn(nil, {
                    i(1, '')
                  })
                end
                local target_variable = get_above_assignment()

                if target_variable ~= nil then
                  return sn(1,
                    {
                      t(vim.trim(target_variable) .. ''),
                      i(1, ''),
                      t(', '),
                    }
                  )
                end

                vim.api.nvim_win_set_cursor(0, pos)
                return sn(nil, {
                  i(1, '')
                })
              end)
            }
          ),
        })),
    s('ll',
      fmt(
        [[
Log::{}({}{});
    ]], {
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
              return "'".. vim.fn.expand('%:t:r') .."#" .. method_name .. "'"
            end

            return "'".. vim.fn.expand('%:t:r') .. "'"
          end),
          i(2, '')
        })),
  },
  -- Autosnippets
  {
  }

