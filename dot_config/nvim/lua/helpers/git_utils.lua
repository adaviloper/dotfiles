local utils = require("helpers.utils")
local M = {}

M.commit_lazy_lock_file = function()
  utils.run_shell_command([[
  chezmoi add ~/.config/nvim/lazy-lock.json
  git add dot_config/nvim/lazy-lock.json; 
  git commit -m "updating lazy lock file";
  ]])
end

return M
