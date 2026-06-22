vim.api.nvim_create_user_command(
  'RunShellCurrentLine',
  '.w !bash',
  {}
)
