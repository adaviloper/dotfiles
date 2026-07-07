local astro = require("astrocore")
local Terminal = require('toggleterm.terminal').Terminal
local utils = require("helpers.utils")

local M = {}

M.default_terminal = Terminal:new({
  display_name = '  Default ',
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
})

M.robo_term = Terminal:new({
  display_name = ' 󱚟 Robot Helper ',
  cmd = 'claude',
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
})

M.fm_term = Terminal:new({
  display_name = ' 󰇥 File Manager ',
  cmd = 'yazi',
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
})

--- @alias TermKey "default" | "robot" | "fm"
M.terminals = {
  default = M.default_terminal,
  robot = M.robo_term,
  fm = M.fm_term,
}

--- @param term_key TermKey
function M.toggle_terminal(term_key)
  local term = M.terminals[term_key]
  if term == nil then return end
  for _, other in pairs(M.terminals) do
    if other ~= term and other:is_open() then
      other:close()
    end
  end
  term:toggle()
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
