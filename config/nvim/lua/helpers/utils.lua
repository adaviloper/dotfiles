local M = {}

function M.better_search(key)
  return function()
    local searched, error =
        pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if not searched and type(error) == "string" then vim.notify(error, vim.log.levels.ERROR) end
  end
end

function M.get_session_name()
 local branch = vim.fn.system("git branch --show-current"):gsub('/', '_')
  if vim.v.shell_error == 0 then
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. '#' .. vim.trim(branch --[[@as string]])
  else
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  end
end

return M
