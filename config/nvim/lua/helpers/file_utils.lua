local M = {}

M.file_exists = function(filepath)
  local file = io.open(filepath, "r") -- Open the file in read mode
  if file ~= nil then
    return file
  end

  return false
end

M.file_is_empty = function (file)
  file = file or io.open(vim.fn.expand('%'), "r")
  if file ~= nil then
    local content = file:read("*all") -- Read the entire content of the file
    file:close()                      -- Close the file

    return content == ""              -- Check if the content is empty
  else
    return false
  end
end

M.file_exists_and_is_empty = function(filepath)
  local file = M.file_exists(filepath) -- Open the file in read mode

  return M.file_is_empty(file)
end

return M
