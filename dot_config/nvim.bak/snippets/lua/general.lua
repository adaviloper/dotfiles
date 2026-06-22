local ls = require "luasnip"
local snippet_from_nodes = ls.sn
local require_var = function(args, _)
  local text = args[1][1] or ""
  local split = vim.split(text, ".", { plain = true })
  local options = {}
  for len = 0, #split - 1 do
    table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
  end
  return snippet_from_nodes(nil, {
    c(1, options),
  })
end

return
  {
    s(
      'req',
      fmta([[local <module_name> = require("<path>")]], {
        module_name = d(2, require_var, { 1 }),
        path = i(1),
      })
    ),
    s(
      'treq',
      fmta([[local <module_name> = require("telescope.<path>")]], {
        module_name = d(2, require_var, { 1 }),
        path = i(1),
      })
    ),
    s(
      'mod',
      fmta([[
      local M = {}

      <insert>

      return M
      ]],
        {
          insert = i(1, ''),
      })
    ),
  },
  {
    s(
      "dml",
      fmta(
        [[
        vim.notify('<loc>: ' .. vim.inspect(<val>))
        ]],
        {
          val = i(1, ''),
          loc = f(function ()
            local pos = vim.api.nvim_win_get_cursor(0)
            return vim.fn.expand('%:t') .. ':' .. pos[1]
          end),
        }
      )
    )
  }
