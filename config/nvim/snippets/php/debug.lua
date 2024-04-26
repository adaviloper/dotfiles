local get_target_node = function(node_name)
  local node = vim.treesitter.get_node()

  while node ~= nil do
    if node:type() == node_name then
      return node
    end

    node = node:parent()
  end
end

return
  -- Snippets
  {
    -- Public function 
    s('dml',
      fmt(
        [[
dd({}__METHOD__ . ':' . __LINE__);
    ]], {
          i(1, ''),
        })),
    s('ll',
      fmt(
        [[
Log::{}({}{});
    ]], {
          c(1, { t('info'), t('error'), t('warning') }),
          f(function ()
            local node = get_target_node('method_declaration')
            if not node then
              vim.notify('No target node found.')
              return
            end

            local method_name = nil
            local query = vim.treesitter.query.parse('php',  "[(method_declaration name: (_) @name)]")
            for _, capture in query:iter_captures(node, 0) do
              method_name = vim.treesitter.get_node_text(capture, 0)
            end

            if method_name ~= nil then
              return "'".. vim.fn.expand('%:t:r') .."#" .. method_name .. "'"
            end

            return "'".. vim.fn.expand('%:t:r') .. "'"
          end),
          i(2, '')
        })),
  },
  -- Autosnippets
  {
  }

