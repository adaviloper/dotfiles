local snippet_utils = require "helpers.snippet_utils"
local ls = require('luasnip')
local file_utils = require('helpers.file_utils')
local group = vim.api.nvim_create_augroup('adaviloper/JSONAutotemplates', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  pattern = { 'http-client.env.json', 'http-client.private.env.json' },
  group = group,
  callback = function (params)
    if not file_utils.file_is_empty() then return end
    local snippet = snippet_utils.find_snippet_by_trigger('env')
    if snippet == nil then return end

    ls.snip_expand(snippet)
    vim.cmd('norm a')
  end,
})

