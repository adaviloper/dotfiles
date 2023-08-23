local get_icon = require("astronvim.utils").get_icon
return {
  "lewis6991/gitsigns.nvim",
  enabled = vim.fn.executable "git" == 1,
  event = "User AstroGitFile",
  opts = {
    signs = {
      add = { text = get_icon "GitAdd" },
      change = { text = get_icon "GitChange" },
      delete = { text = get_icon "GitDelete" },
      topdelete = { text = get_icon "GitSign" },
      changedelete = { text = get_icon "GitSign" },
      untracked = { text = get_icon "GitSign" },
    },
    worktrees = vim.g.git_worktrees,
    numhl = true,
  },
}
