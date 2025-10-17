local ft_patterns = {
  javascript =  "console.log('.*.ts:\\d*",
  lua = "vim.notify(vim.inspect(",
  php =  "dd(.* __METHOD__",
  typescript = "console.log('.*.ts:\\d*",
}

vim.api.nvim_create_user_command(
  'ClearDebugLogs',
  function ()
    local pattern = ft_patterns[vim.bo.filetype]
    vim.notify(vim.inspect(pattern))

    vim.cmd('g/' .. pattern .. '/d')
  end,
  {}
)
