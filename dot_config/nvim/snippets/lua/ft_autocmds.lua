return
  {
    s(
      {
        trig = "ft_auto_keybinds",
      },
      fmta(
        [[
local astrocore = require("astrocore")

astrocore.set_mappings({
  n = {
    <lhs> = { <rhs>, desc = "<desc>" },
  },
})
        ]],
        {
          lhs = c(1, {
            sn(
              nil,
              fmta([=[
            ['<key>']
            ]=], {
                key = i(1, ''),
              })
            ),
            i(''),
          }),
          rhs = c(2, {
            sn(
              nil,
              fmta([=[
            function()
              <body>
            end
            ]=], {
                body = i(1, ''),
              })
            ),
            sn(
              nil,
              fmta(
                [[
                "<ins>"
                ]],
                {
                  ins = i(1, ''),
                }
              )
            )
          }),
          desc = i(3),
        }
      )
    ),

    s(
      {
        trig = "ft_auto_template",
      },
      fmta(
        [[
local snippet_utils = require("helpers.snippet_utils")
local ls = require('luasnip')
local file_utils = require('helpers.file_utils')

local <lang>_group = vim.api.nvim_create_augroup('adaviloper/<rep_lang>_autotemplates', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '<pattern>.<rep_lang>',
  group = <rep_lang>_group,
  callback = function (params)
    if not file_utils.file_is_empty() then return end
    local snippet = snippet_utils.find_snippet_by_trigger('<snippet>')
    if snippet == nil then return end

    ls.snip_expand(snippet)
    vim.cmd('norm a')
  end,
})
        ]],
        {
          lang = i(1),
          rep_lang = rep(1),
          pattern = c(2, {
            t('*'),
            i(''),
          }),
          snippet = i(3),
        }
      )
    ),
  },
  {
  }
