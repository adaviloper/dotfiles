local ts = vim.treesitter
local query = vim.treesitter.query
local parsers = require("nvim-treesitter.parsers")

local function cursor_in_node(node, cursor_row, cursor_col)
  local sr, sc, er, ec = node:range()
  return (cursor_row > sr or (cursor_row == sr and cursor_col >= sc)) and
         (cursor_row < er or (cursor_row == er and cursor_col <= ec))
end

local function toggle_arrow_function_under_cursor()
  local buf = 0
  local parser = parsers.get_parser()
  local lang = parser:lang()
  local tree = parser:parse()[1]
  local root = tree:root()

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1 -- 0-based indexing

  local q = query.parse(
    lang,
    [[
    (arrow_function
      parameters: (formal_parameters) @params
      return_type: (type_annotation) @return_type
      body: (_) @body)
  ]]
  )

  local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  cursor_row = cursor_row - 1 -- 0-based indexing

  -- Find the smallest node at the cursor
  local node = root:named_descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)

  -- Ensure we found a node and it's an arrow_function
  if not node then
    print("No node found under cursor.")
    return
  end

  -- Walk up to the arrow_function node
  while node and node:type() ~= "arrow_function" do
    node = node:parent()
  end

  if not node then
    print("No arrow function under cursor.")
    return
  end

  for _, match, metadata in q:iter_matches(node, buf) do
    local body_node, param_node, type_node
    local arrow_function_node = node -- since we walked up to it

    for id, matched_node in pairs(match) do
      local name = q.captures[id]
      if name == "body" then
        body_node = matched_node[1]
      elseif name == "return_type" then
        type_node = matched_node[1]
      elseif name == "params" then
        param_node = matched_node[1]
      end
    end

    -- Check if cursor is inside the body node
    local start_row, start_col, end_row, end_col = body_node:range()

    if cursor_in_node(arrow_function_node, row, col) then
      local body_type = body_node:type()
      local type = type_node and vim.treesitter.get_node_text(type_node, buf) or ""
      local _, _, _, param_end_col = param_node:range()

      if body_type ~= "statement_block" then
        -- Concise → Block
        local expr = vim.treesitter.get_node_text(body_node, buf)
        local expr_lines = vim.split(expr, "\n")
        local output = {
          "{",
        }
        if #expr_lines > 1 then
          expr_lines[1] = 'return {'
          expr_lines[#expr_lines] = '};'
          for _, key_val in ipairs(expr_lines) do
            table.insert(output, key_val)
          end
        else
          table.insert(output, "  return " .. expr .. ";")
        end
        table.insert(output, "}")
        vim.api.nvim_buf_set_text(buf, start_row, start_col, end_row, end_col, output)
        vim.cmd('norm =af')
      else
        -- Block → Concise
        for child in body_node:iter_children() do
          if child:type() == "return_statement" and child:child(1) then
            local expr = type .. ' => ' .. vim.treesitter.get_node_text(child:child(1), buf)

            local expr_lines = vim.split(expr, "\n")
            local output = {
            }
            if #expr_lines > 1 then
              expr_lines[1] = '({'
              expr_lines[#expr_lines] = '})'
              for _, key_val in ipairs(expr_lines) do
                table.insert(output, key_val)
              end
            else
              table.insert(output, expr)
            end

            vim.api.nvim_buf_set_text(buf, start_row, start_col, end_row, end_col, output)
            vim.cmd('norm =af')
            return
          end
        end
      end

      return
    end
  end

  print("No arrow function body under cursor.")
end

vim.api.nvim_create_user_command("ToggleArrowFunction", toggle_arrow_function_under_cursor, {})

