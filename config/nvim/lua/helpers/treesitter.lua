local ts = vim.treesitter
local parsers = require "nvim-treesitter.parsers"

local M = {}

M.get_target_node = function(node_names)
  if type(node_names) ~= 'table' then
    node_names = { node_names }
  end
  local node = vim.treesitter.get_node()

  while node ~= nil do
    if vim.tbl_contains(node_names, node:type()) then
      return node
    end

    node = node:parent()
  end

  return nil
end

M.parse_query_for_capture = function (node, query_to_parse, target)
  local query = ts.query.parse(parsers.get_buf_lang(), query_to_parse)
  local captures = {}
  for i, match, _ in query:iter_captures(node, 0) do
    local name = query.captures[i]
    vim.notify(name)
    if name == target then
      table.insert(captures, ts.get_node_text(match, 0))
    end
  end

  return captures

end

return M
