return {
  {
    'tpope/vim-fugitive',
  },
  {
    'shumphrey/fugitive-gitlab.vim',
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = vim.fn.executable("git") == 1,
    event = "User AstroGitFile",
    opts = {
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        ignore_whitespace = true,
      },
      numhl = true,
      signcolumn = false,
      sign_priority = 11,
      worktrees = vim.g.git_worktrees,
    },
  }
}
