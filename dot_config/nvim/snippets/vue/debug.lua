local get_target_node = require('helpers.treesitter').get_target_node
local parse_query_for_capture = require('helpers.treesitter').parse_query_for_capture

return
  {
    s(
      'dml',
      fmt(
        [[console.log('{}'{});]],
        {
          f(
            function ()
              local line_number = vim.api.nvim_win_get_cursor(0)
              return vim.fn.expand('%:t') .. line_number[1]
            end
          ),
          d(1, function()
	          local parser = vim.treesitter.get_parser()
	          if not parser then
		          return
	          end

	          parser:parse(true) -- parse all injected regions. Does nothing if buffer is already parsed

            local pos = vim.api.nvim_win_get_cursor(0)
            local prev_line = vim.api.nvim_buf_get_lines(0, pos[1] - 2, pos[1] - 1, false)
            if prev_line[1] == '' then
              return sn(nil, {
                i(1, '')
              })
            end
            vim.cmd('norm k$')
	          local node = vim.treesitter.get_node({ ignore_injections = false })

	          if node == nil then return sn(1, { t('') }) end

	          while node:type() ~= 'lexical_declaration' do
	            node = node:parent()
	            if node == nil then return '' end
	          end

            local query = [[
            (lexical_declaration
              (variable_declarator
                name: (identifier) @var
                )
              )
            ]]
            local var = parse_query_for_capture(node, query, 'var')[1]
            vim.api.nvim_win_set_cursor(0, pos)

	          -- __AUTO_GENERATED_PRINT_VAR_START__
	          return sn(1,
	            {
	              t(', ' .. var)
	            })
          end),
        }
      )
    )
  },
  {}

