local not_in_nodes_condition = function (ignored_nodes)
  return function ()
    local pos = vim.api.nvim_win_get_cursor(0)
    local row, col = pos[1] - 1, pos[2] - 1

    local node_type = vim.treesitter.get_node({
      pos = { row, col }
    }):type()

    return not vim.tbl_contains(ignored_nodes, node_type)
  end
end

return
  {
    s(
      {
        trig = "for([%w_]+)",
        regTrig = true,
        condition = not_in_nodes_condition({ 'string', 'comment' }),
      },
      fmt([[
      for (${} = 0; ${} < {}; ${}++) {{
          {}
      }}
      ]],
        {
          d(1, function (_, snip)
            return sn(1, i(1, snip.captures[1]))
          end),
          rep(1),
          i(2, 'limit'),
          rep(1),
          i(3, ''),
        }
      )
    ),
  },
  {
    s(
      {
        trig = 'el ',
        condition = not_in_nodes_condition({ 'string', 'comment' }),
      },
      fmt(
        [[
        else {{
            {}
        }}
        ]],
        {
          i(1, ''),
        }
      )
    ),
    s(
      {
        trig = 'elif ',
        condition = not_in_nodes_condition({ 'string', 'comment' }),
      },
      fmt(
        [[
        else if (${}) {{
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
      {
        trig = 'if ',
        condition = not_in_nodes_condition({ 'string', 'comment' }),
      },
      fmt(
        [[
        if (${}) {{
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
      'fore ',
      fmt([[
      foreach (${} as ${}{}) {{
          {}
      }}
      ]],
        {
          d(1, function (_, snip)
            return sn(1, i(1, snip.captures[1]))
          end),
          rep(1),
          i(2, ''),
          i(3, ''),
        }
      )
    ),
    s(
      {
        trig = 'match ',
        condition = not_in_nodes_condition({ 'string', 'comment' }),
      },
      fmt(
        [[
        match (${}) {{
            {} => {},
            default => {}
        }}
        ]],
        {
          i(1, 'constraint'),
          i(2, 'case'),
          i(3, 'return_val'),
          i(4, 'default_return'),
        }
      )
    ),
    s(
      {
        trig = 'try ',
        condition = not_in_nodes_condition({ 'string', 'comment' }),
      },
      fmt(
        [[
        try {{
            {}
        }} catch (Throwable $exception) {{
            {}
        }}
        ]],
        {
          i(1, ''),
          i(2, ''),
        }
      )
    ),
  }
