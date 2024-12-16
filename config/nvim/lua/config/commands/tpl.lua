local M = {}

M.insert_template = function(template)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if #lines == 1 and lines[1] == '' then
    vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
  end
end

return M
