return {
  {
    'tpope/vim-fugitive',
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = vim.fn.executable("git") == 1,
    event = "User AstroGitFile",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        ignore_whitespace = false,
      },
      numhl = true,
      signcolumn = false,
      worktrees = vim.g.git_worktrees,
    },
  }
}
