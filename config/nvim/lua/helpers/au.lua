local M = {}

--- Establish empty file templates when entering a buffer
--- @param au_group string
--- @param pattern string
--- @param contents string[]
M.empty_file_template = function (au_group, pattern, contents)
  vim.api.nvim_create_augroup(au_group, {
    clear = true,
  })

  vim.api.nvim_create_autocmd('BufEnter', {
    group = au_group,
    pattern = pattern,
    callback = function(event)
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      if #lines == 1 and lines[1] == '' then
        vim.api.nvim_buf_set_lines(
          event.buf,
          0,
          1,
          true,
          contents
        )
      end
    end
  })
end

return M
