function extract_to_variable()
  local bufnr = vim.api.nvim_get_current_buf()
  local start_pos = vim.fn.getpos(".")
  local end_pos = vim.fn.getpos("v")

  if start_pos[2] == end_pos[2] then
    if start_pos[3] > end_pos[3] then
      local temp = start_pos
      start_pos = end_pos
      end_pos = temp
    end
  elseif start_pos[2] > end_pos[2] then
    local temp = start_pos
    start_pos = end_pos
    end_pos = temp
  end

  local start_row = start_pos[2] - 1
  local start_col = start_pos[3] - 1
  local end_row = end_pos[2] - 1
  local end_col = end_pos[3]

  vim.ui.input(
    {
      prompt = "New variable name:",
    },
    function (entry)
      if entry == nil then
        return
      end
      -- Get the selected text
      local lines = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})
      local selected_text = table.concat(lines, "\n")

      -- Insert the new variable assignment above the current line
      local var_name = entry
      local assignment_line = string.format("const %s = %s;", var_name, selected_text)
      vim.api.nvim_buf_set_lines(bufnr, start_row, start_row, false, { assignment_line })

      -- Replace the selection with the new variable name
      vim.api.nvim_buf_set_text(bufnr, start_row + 1, start_col, end_row + 1, end_col, { var_name })
      vim.cmd('norm =ip')
    end
  )
end

vim.api.nvim_create_user_command("ExtractToVariable", extract_to_variable, {})

