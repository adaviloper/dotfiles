local M = {}

function M.get_session_name()
  local branch = vim.fn.system("git branch --show-current"):gsub("/", "_")
  if vim.v.shell_error == 0 then
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. "#" .. vim.trim(branch --[[@as string]])
  else
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  end
end

return M
