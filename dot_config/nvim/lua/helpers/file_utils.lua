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

M.extension = function()
  return vim.fn.expand("%:p:e")
end

M.name = function()
  return vim.fn.expand("%:p")
end

M.path = function()
  return vim.fn.expand("%:p:.")
end

M.toggle_source_test = function()
  local filepath = vim.fn.expand("%:p")
  if filepath == "" then
    vim.notify("No file loaded", vim.log.levels.WARN)
    return
  end

  local filename = vim.fn.expand("%:t:r") -- filename without extension
  local extension = vim.fn.expand("%:e") -- file extension
  local target

  -- Determine if current file is a test file or source file
  local is_test_file = filename:match("%.spec$") or filename:match("%.test$") or filename:match("Test$")

  if is_test_file then
    -- Test file → Source file
    local source_filename = filename:gsub("%.spec$", ""):gsub("%.test$", ""):gsub("Test$", "")
    local search_pattern = source_filename .. "." .. extension

    -- Search for source file in the repository
    local search_cmd = "find . -name '" .. search_pattern .. "' -type f | head -1"
    local result = vim.fn.system(search_cmd)

    if vim.v.shell_error == 0 and result and result ~= "" then
      target = vim.trim(result)
    else
      vim.notify("No corresponding source file found for: " .. search_pattern, vim.log.levels.WARN)
      return
    end
  else
    -- Source file → Test file
    local test_patterns = {}

    if extension == "php" then
      -- PHP: filename.php → filenameTest.php
      table.insert(test_patterns, filename .. "Test." .. extension)
    else
      -- JS/TS: filename.ts → filename.spec.ts, filename.test.ts
      table.insert(test_patterns, filename .. ".spec." .. extension)
      table.insert(test_patterns, filename .. ".test." .. extension)
    end

    target = nil
    for _, pattern in ipairs(test_patterns) do
      local search_cmd = "find . -name '" .. pattern .. "' -type f | head -1"
      local result = vim.fn.system(search_cmd)

      if vim.v.shell_error == 0 and result and result ~= "" then
        target = vim.trim(result)
        break
      end
    end

    if not target then
      vim.notify("No corresponding test file found for: " .. filename .. "." .. extension, vim.log.levels.WARN)
      return
    end
  end

  if target and vim.fn.filereadable(target) == 1 then
    vim.cmd.edit(target)
  else
    vim.notify("Target file not readable: " .. (target or "unknown"), vim.log.levels.WARN)
  end
end

return M
