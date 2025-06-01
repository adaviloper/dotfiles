local yaml_group = vim.api.nvim_create_augroup('adaviloper/espanso-restart', { clear = true })
local function restart_espanso(opts)
    local bufnr = opts.buf
    local file_name = vim.api.nvim_buf_get_name(bufnr)
    if file_name:match('config/espanso') then
      local handle = io.popen('espanso restart')
      if handle then
        handle:close()
      end
    end
  end

vim.api.nvim_create_autocmd('BufWritePost',  {
  group = yaml_group,
  pattern = '*.yml',
  callback = restart_espanso
})

vim.api.nvim_create_autocmd('User',  {
  group = yaml_group,
  pattern = 'AutoSaveWritePost',
  callback = restart_espanso
})
