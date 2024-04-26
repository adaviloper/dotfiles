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
  -- Autosnippets
  {
    -- Public function 
    s('dml',
      fmt(
        [[
dd({}__METHOD__ . ':' . __LINE__);
    ]], {
          sn(
            1,
            {
              d(1, function (args)
                local pos = vim.api.nvim_win_get_cursor(0)
                local prev_line = vim.api.nvim_buf_get_lines(0, pos[1] - 2, pos[1] - 1, false)
                local statement = vim.split(prev_line[1], '=', { trimempty = true })

                if string.find(prev_line[1], '=') ~= nil then
                  return sn(0,
                    {
                      t(vim.trim(statement[1]) .. ', '),
                      i(0, ''),
                    }
                  )
                end

                if statement[1] == nil or statement[1] == '' then
                  return sn(nil, {
                    i(1, '')
                  })
                end
              end)
            }
          ),
        })),
    s('ll',
      fmt(
        [[
Log::{}({}{});
    ]], {
          c(1, { t('info'), t('error'), t('warn') }),
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

