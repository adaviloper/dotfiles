local ts = vim.treesitter
local parsers = require "nvim-treesitter.parsers"

local M = {}

M.get_target_node = function(node_name)
  local node = vim.treesitter.get_node()

  while node ~= nil do
    if node:type() == node_name then
      return node
    end

    node = node:parent()
  end

  return nil
end

M.parse_query_for_capture = function (node, query_to_parse, target)
  local query = ts.query.parse(parsers.get_buf_lang(), query_to_parse)
  for i, match, _ in query:iter_captures(node, 0) do
    local name = query.captures[i]
    if name == target then
      return ts.get_node_text(match, 0)
    end
  end

end

return M
