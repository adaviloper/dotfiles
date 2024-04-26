return
  {
    s(
      'try',
      fmt(
        [[
        try {{
            {}
        }} catch(Throwable $exception) {{
            {}
        }}
        ]],
        {
          i(1, ''),
          i(2, ''),
        }
      )
    ),
    s(
      '/**',
      fmt(
        [[
        /** @var {} {} */
        ]],
        {
          i(1, ''),
          d(2, function (args)
            local pos = vim.api.nvim_win_get_cursor(0)
            local next_line = vim.api.nvim_buf_get_lines(0, pos[1] + 0, pos[1] + 1, false)
            vim.notify(vim.inspect(next_line))
            local statement = vim.split(next_line[1], '=', { trimempty = true })

            if string.find(next_line[1], '=') ~= nil then
              return sn(0,
                {
                  t(vim.trim(statement[1])),
                  i(0, ''),
                }
              )
            end

            return sn(nil, {
              i(1, '')
            })
          end)
        }
      )
    ),
  },
  {
    -- s(
    --   {
    --     trigger = 'if ',
    --     condition = function()
    --       local ignored_nodes = { 'string', 'comment' }
    --       local pos = vim.api.nvim_win_get_cursor(0)
    --       vim.notify('hit')
    --
    --       local row, col = pos[1] - 1, pos[2] - 1
    --
    --       local node_type = vim.treesitter.get_node({
    --         pos = { row, col },
    --       }):type()
    --
    --       return not vim.tbl_contains(ignored_nodes, node_type)
    --     end,
    --   },
    --   fmt(
    --     [[
    --     if ({}) {{
    --         {}
    --     }}
    --     ]],
    --     {
    --       i(1, 'condition'),
    --       i(2, 'END'),
    --     }
    --   )
    -- )
  }
