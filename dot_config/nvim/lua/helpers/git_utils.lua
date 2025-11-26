local M = {}

M.commit_lazy_lock_file = function()
  vim.fn.system({ "chezmoi", "add", "~/.config/nvim/lazy-lock.json" })
  vim.fn.system({ "git", "add", "dot_config/nvim/lazy-lock.json" })
  vim.fn.system({ "git", "commit", "-m", "updating", "lazy", "lock", "file" })
end

M.get_git_branch = function()
  local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  if handle then
    local branch = handle:read("*l")

    handle:close()
    return branch or ""
  end
  return ""
end

M.signal_branch_change = function()
  vim.api.nvim_exec_autocmds("User", { pattern = "GitBranchChange" })
end

return M
