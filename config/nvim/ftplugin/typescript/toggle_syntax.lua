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

  -- Walk up to the arrow_function node
  while node and node:type() ~= "arrow_function" do
    node = node:parent()
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
        vim.api.nvim_buf_set_text(buf, start_row, start_col, end_row, end_col, {
          "{",
          "  return " .. expr .. ";",
          "}",
        })
        vim.cmd('norm $=%')
      else
        -- Block → Concise
        for child in body_node:iter_children() do
          if child:type() == "return_statement" and child:child(1) then
            local expr = type .. ' => ' .. vim.treesitter.get_node_text(child:child(1), buf)
            vim.api.nvim_buf_set_text(buf, start_row, param_end_col, end_row, end_col, { expr })
            return
          end
        end
        vim.cmd('norm ==')
      end

      return
    end
  end

  print("No arrow function body under cursor.")
end

vim.api.nvim_create_user_command("ToggleArrowFunction", toggle_arrow_function_under_cursor, {})
