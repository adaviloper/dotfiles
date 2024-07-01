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
local require_var = function(args, _)
  local text = args[1][1] or ""
  local split = vim.split(text, ".", { plain = true })

  local options = {}
  for len = 0, #split - 1 do
    table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
  end

  return sn(nil, {
    c(1, options),
  })
end

return
  {
    s(
      'req',
      fmt([[local {} = require("{}")]], {
        d(2, require_var, { 1 }),
        i(1),
      })
    ),

    s(
      'treq',
      fmt([[local {} = require("telescope.{}")]], {
        d(2, require_var, { 1 }),
        i(1),
      })
    ),
  },
  {
    s(
      {
        trig = 'if ',
        condition = not_in_nodes_condition({ 'string_content', 'comment' }),
      },
      fmt(
        [[
        if {} then
          {}
        end
        ]],
        {
          i(1, 'condition'),
          i(0)
        }
      )
    ),
    s(
      {
        trig = 'el ',
        condition = not_in_nodes_condition({ 'string_content', 'comment' }),
      },
      fmt(
        [[
        else
          {}
        ]],
        {
          i(0)
        }
      )
    ),
    s(
      {
        trig = 'elif ',
        condition = not_in_nodes_condition({ 'string_content', 'comment' }),
      },
      fmt(
        [[
        else if {} then
          {}
        ]],
        {
          i(1, 'condition'),
          i(0)
        }
      )
    ),
  }
