local php_group = vim.api.nvim_create_augroup('PHP AutoTemplates', { clear = true })

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  pattern = '*.php',
  group = php_group,
  callback = function (params)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    if #lines > 1 and lines[1] == '' then
      local client = vim.lsp.get_client_by_id(params.data.client_id)
      if client == nil then return end

      if client.supports_method('textDocument/codeAction') then
        vim.lsp.buf.code_action({
          filter = function (ca)
            if ca.command ~= nil and ca.command.title ~= nil then
              local file = vim.fn.expand("%:p:.")
              for _, type in ipairs({ 'Feature', 'Unit', 'Job', 'Listener', 'Model' }) do
                if file:find(type) then
                  return ca.command.title:find(type) ~= nil
                end
              end
              if ca.command.title:find('default') then
                return true
              end
            end
            return false
          end,
          apply = true
        })
      end
    elseif #lines == 1 then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, {"<?php", "", ""})
    end
  end,
})
