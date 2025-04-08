local M = {}

function run_shell_command(str)
  local handle = io.popen(str)
  if handle then
    handle:close()
  end
end

M.commit_lazy_lock_file = function()
  run_shell_command("git add config/nvim/lazy-lock.json; git commit -m \"updating lazy lock file\"")
end

return M
