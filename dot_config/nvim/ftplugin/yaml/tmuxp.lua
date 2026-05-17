local lua_group = vim.api.nvim_create_augroup('adaviloper/YamlAutotemplates', { clear = true })

local snippet_utils = require "helpers.snippet_utils"
local ls = require('luasnip')
local file_utils = require('helpers.file_utils')

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*/dot_config/tmuxp/*.yaml',
  group = lua_group,
  callback = function (params)
    if not file_utils.file_is_empty() then return end
    local snippet = snippet_utils.find_snippet_by_trigger('workspace')
    if snippet == nil then return end

    ls.snip_expand(snippet)
    vim.cmd('norm a')
  end,
})

