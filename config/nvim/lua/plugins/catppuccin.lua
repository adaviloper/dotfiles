return {
  'catppuccin/nvim',
  name = 'catppuccin',
  opts = {
    load = {
      -- 'catppuccin-mocha-cursor',
    },
    dim_inactive = {
      enabled = true,
      shade = "dark",
      percentage = 0.35,
    },
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      keywords = { 'bold' },
      types = { 'bold' },
    },
    highlight_overrides = {
      mocha = function (mocha)
        return {
          DiagnosticUnderlineError = { undercurl = true, sp = mocha.red },
          DiagnosticUnderlineWarn = { undercurl = true, sp = mocha.yellow },
          DiagnosticUnderlineInfo = { undercurl = true, sp = mocha.sky },
          SpellBad = { undercurl = true, sp = mocha.green },
        }
      end,
    },
  },
}
