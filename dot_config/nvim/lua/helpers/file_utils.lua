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

  local target

  -- ✅ JS / TS logic
  if filepath:match("/src/") and (filepath:match("%.ts$") or filepath:match("%.js$")) then
    -- src → test(s)
    target = filepath:gsub("/src/", "/tests/")
    target = target:gsub("(%w+)%.([tj]s)$", "%1.test.%2")

    local spec = target:gsub("%.test%.([tj]s)$", ".spec.%1")
    if vim.fn.filereadable(spec) == 1 then
      target = spec
    end

  elseif filepath:match("/test[s]*/") and (filepath:match("%.ts$") or filepath:match("%.js$")) then
    -- test(s) → src
    target = filepath:gsub("/test[s]*/", "/src/")
    target = target:gsub("%.spec%.([tj]s)$", ".%1")
    target = target:gsub("%.test%.([tj]s)$", ".%1")

  -- ✅ PHP / PHPUnit logic
  elseif filepath:match("/src/") and filepath:match("%.php$") then
    -- src → test(s)
    target = filepath:gsub("/src/", "/tests/")
    target = target:gsub("(%w+)%.php$", "%1Test.php")

  elseif filepath:match("/test[s]*/") and filepath:match("%.php$") then
    -- test(s) → src
    target = filepath:gsub("/test[s]*/", "/src/")
    target = target:gsub("Test%.php$", ".php")

  else
    vim.notify("File not in src/ or test(s)/, or unsupported extension", vim.log.levels.WARN)
    return
  end

  if vim.fn.filereadable(target) == 1 then
    vim.cmd.edit(target)
  else
    vim.notify("No corresponding file: " .. target, vim.log.levels.WARN)
  end
end

return M
