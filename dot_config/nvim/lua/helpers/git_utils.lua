local M = {}

M.commit_lazy_lock_file = function()
  vim.fn.system({ "chezmoi", "add", "~/.config/nvim/lazy-lock.json" })
  vim.fn.system({ "git", "add", "dot_config/nvim/lazy-lock.json" })
  vim.fn.system({ "git", "commit", "-m", "updating", "lazy", "lock", "file" })
end

return M
