local php_group = vim.api.nvim_create_augroup('PHP AutoTemplates', { clear = true })

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  pattern = '*.php',
  group = php_group,
  callback = function (params)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    if #lines == 1 and lines[1] == '' then
      local client = vim.lsp.get_client_by_id(params.data.client_id)
      if client == nil then return end
      local file = vim.fn.expand("%:p:.")
      local match_position = -1
      local target_type = 'default'
      for _, type in ipairs({ 'Enum', 'Feature', 'Unit', 'Jobs', 'Listeners', 'Models' }) do
        local pos = file:find(type)
        if pos ~= nil then
          if match_position == -1 or pos < match_position then
            target_type = type
            match_position = pos
          end
        end
      end

      if client.supports_method('textDocument/codeAction') then
        vim.lsp.buf.code_action({
          filter = function (ca)
            if ca.command ~= nil and ca.command.title ~= nil then
              if ca.command.title:find(target_type) ~= nil then
                return true
              end
            end
          end,
          apply = true
        })
      else
        vim.api.nvim_buf_set_lines(0, 0, -1, false, { '<?php', '', '' })
      end
    end
  end,
})

local win_group = vim.api.nvim_create_augroup('Split Manager', { clear = true })

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = win_group,
  pattern = { 'help', 'man' },
  command = 'wincmd L',
})

local misc_group = vim.api.nvim_create_augroup('Miscellaneous', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  group = misc_group,
  pattern = {
    '*.js',
    '*.lua',
    '*.php',
    '*.ts',
    '*.vue',
  },
  command = 'checktime',
})
