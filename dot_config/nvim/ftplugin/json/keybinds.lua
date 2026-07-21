local astrocore = require("astrocore")
local snippet_utils = require "helpers.snippet_utils"
local ls = require('luasnip')

astrocore.set_mappings({
  i = {
    ['<A-CR>'] = {
      function()
        local pos = vim.api.nvim_win_get_cursor(0)
        local line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)
        local ends_in_comma = line[#line]:sub(-1) == ','
        if ends_in_comma == false then
          vim.cmd('norm A,')
        end

        local indent = line[#line]:match('^%s*')
        vim.api.nvim_buf_set_lines(0, pos[1], pos[1], false, { indent })
        vim.api.nvim_win_set_cursor(0, { pos[1] + 1, #indent })
        vim.cmd('startinsert!')

        local snippet = snippet_utils.find_snippet_by_trigger('kvpair')
        if snippet == nil then return end

        ls.snip_expand(snippet)
        vim.cmd('norm a')
      end,
      desc = "Add new key-value pair",
    },
  },
})
