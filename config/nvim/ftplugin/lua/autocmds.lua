local lua_group = vim.api.nvim_create_augroup('adaviloper/LuaAutotemplates', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*/snippets/*.lua',
  group = lua_group,
  callback = function (params)
    local template_inserted = require('config.commands.tpl').insert_template({
      'return',
      '  {',
      '    ',
      '  },',
      '  {',
      '  }',
    })
    if template_inserted then
      vim.api.nvim_win_set_cursor(0, { 3, 4 })
    end
  end,
})

