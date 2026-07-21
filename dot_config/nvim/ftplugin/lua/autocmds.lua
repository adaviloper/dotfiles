local snippet_utils = require "helpers.snippet_utils"
local ls = require('luasnip')
local file_utils = require('helpers.file_utils')
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

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*/ftplugin/*/*_template.lua',
  group = lua_group,
  callback = function (params)
    if not file_utils.file_is_empty() then return end
    local snippet = snippet_utils.find_snippet_by_trigger('ft_auto_template')
    if snippet == nil then return end

    ls.snip_expand(snippet)
    vim.cmd('norm a')
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*/ftplugin/*/*keybinds*.lua',
  group = lua_group,
  callback = function (params)
    if not file_utils.file_is_empty() then return end
    local snippet = snippet_utils.find_snippet_by_trigger('ft_auto_keybinds')
    if snippet == nil then return end

    ls.snip_expand(snippet)
    vim.cmd('norm a')
  end,
})

