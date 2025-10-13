local ts_utils = require("helpers.treesitter")
local ls = require("luasnip")
local t = ls.text_node
local f = ls.f
local i = ls.i

local function get_return_types(args, opts)
  local node = ts_utils.get_target_node({ "func_literal", 'function_declaration' })
  if not node then
    return t("")
  end

  -- Match all result type nodes — identifiers, pointers, selectors, etc.
  local types = ts_utils.parse_query_for_capture(node, [=[
[
 (function_declaration
   result: (type_identifier) @types
    )
 (function_declaration
   result: (parameter_list
             (parameter_declaration
               (type_identifier) @types
               )
             )
   )
 (func_literal
   result: [
            (type_identifier) @types
            (pointer_type (type_identifier) @types)
            (qualified_type (package_identifier) @pkg (type_identifier) @types)
            ]
   ) @func
 ]
  ]=], "types")

  if not types or #types == 0 then
    return t("")
  end
  vim.notify('args: ' .. vim.inspect(args[1]))

  local mapped = {}
  for _, type_name in ipairs(types) do
    -- Normalize type name (e.g., strip "*" or spaces)
    type_name = type_name:gsub("^%*", ""):gsub("%s+", "")

    local v
    if type_name == "int" or type_name == "int64" or type_name == "float64" then
      v = "0"
    elseif type_name == "string" then
      v = '""'
    elseif type_name == "bool" or type_name == "boolean" then
      v = "false"
    elseif type_name == "error" then
      vim.notify(vim.inspect('adding error'))
      v = args[1][1]
    elseif type_name:match("^%u") then
      -- Likely a struct or custom type
      v = "nil"
    else
      v = "nil"
    end
    table.insert(mapped, v)
  end
  vim.notify('mapped count: ' .. vim.inspect(#mapped))
  vim.notify('mapped: ' .. vim.inspect(table.concat(mapped, ", ")))

  local result = table.concat(mapped, ", ")
  vim.notify(vim.inspect(result))
  return result
end

return
  {
    s(
      "erv",
      fmta(
      [[
      <var>, <err> := <func>(<args>)
      if <rep_err> != nil {
        return <ret_val>
      }
      ]],
      {
        var = i(1, "v"),
        err = i(2, "err"),
        func = i(3),
        args = i(4, ""),
        ret_val = f(get_return_types, {2}),
        rep_err = rep(2),
      }
    )
    )
  },
  {
  }
