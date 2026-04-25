local astro = require("astrocore")
local Terminal = require('toggleterm.terminal').Terminal
local utils = require("helpers.utils")

local M = {}

M.default_terminal = Terminal:new({
  display_name = ' Default ',
  direction = 'float',
})

M.robo_term = Terminal:new({
  display_name = ' Robot Helper ',
  cmd = 'claude',
  direction = 'float',
})

M.toggle_robo = function()
  if M.default_terminal:is_open() then
    M.default_terminal:close()
    M.robo_term:open()
  else
    M.robo_term:toggle()
  end
end

M.toggle_default = function()
  if M.robo_term:is_open() then
    M.robo_term:close()
    M.default_terminal:open()
  else
    M.default_terminal:toggle()
  end
end

M.lazy_git = function()
  local git_utils = require("helpers.git_utils")
  local current_branch = git_utils.get_git_branch()
  local worktree = astro.file_worktree()
  local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
  or ""
  astro.toggle_term_cmd(
    {
      cmd = "lazygit " .. flags,
      direction = "float",
      on_open = function ()
        require("resession").save(
          utils.get_session_name(),
          {
            notify = true,
          }
        )
      end,
      on_close = function ()
        local new_branch = git_utils.get_git_branch()

        if new_branch ~= current_branch then
          git_utils.signal_branch_change()
        end
      end
    }
  )
end

return M
