local snippet_utils = require("helpers.snippet_utils")
local ls = require('luasnip')
local file_utils = require('helpers.file_utils')

local ts_group = vim.api.nvim_create_augroup('adaviloper/ts_autotemplates', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*/viteburner-template/src/*.ts',
  group = ts_group,
  callback = function (params)
    if not file_utils.file_is_empty() then return end
    local snippet = snippet_utils.find_snippet_by_trigger('bb_start')
    if snippet == nil then return end

    ls.snip_expand(snippet)
    vim.cmd('norm a')
  end,
})
