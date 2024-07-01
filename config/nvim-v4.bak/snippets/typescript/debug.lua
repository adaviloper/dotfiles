local get_target_node = require('helpers.treesitter').get_target_node
local parse_query_for_capture = require('helpers.treesitter').parse_query_for_capture

local get_above_assignment = function ()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { pos[1] - 1, pos[2] })
  vim.cmd('norm $')
  --- @type TSNode|nil {node}
  local node = get_target_node('variable_declarator')

  if not node then
    return
  end

  local assignment_query = [[
(variable_declarator
  name: (_) @var
  ) @declaration
]]
  return parse_query_for_capture(node, assignment_query, 'var')
end

return
    {
    s('cml',
      fmt(
        '{}',
        {
          -- c(1, {
          --   t('log'),
          --   t('error'),
          --   t('warn'),
          --   t('table'),
          --   t('info'),
          -- }),
          -- f(function (args)
          --   local filename = vim.fn.expand('%:t:r')
          --   local position = vim.fn.getcurpos(0)
          --
          --   return filename .. ':' .. tostring(position[2])
          -- end),
          -- i(2, ''),
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
                vim.api.nvim_win_set_cursor(0, pos)
                P(target_variable)

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
        }
      )
    ),
  },
  {

  }
