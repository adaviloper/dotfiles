local M = {}

M.file_exists = function(filepath)
  if not filepath or filepath == "" then return false end
  local handle = io.open(filepath, "r")
  if handle ~= nil then
    handle:close()
    return true
  end
  return false
end

M.file_is_empty = function(filepath)
  if not filepath or filepath == "" then return false end
  local handle = io.open(filepath, "r")
  if handle == nil then return false end
  local content = handle:read("*a")
  handle:close()
  return content == nil or content == ""
end

M.file_exists_and_is_empty = function(filepath)
  return M.file_is_empty(filepath)
end

return M
