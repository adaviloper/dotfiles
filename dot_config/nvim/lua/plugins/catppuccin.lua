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
          WindowPickerWinBarNC = { bg = mocha.sky, fg = mocha.surface1 },
          WinSeparator = { fg = mocha.mauve },

          -- Neotest
          NeotestAdapterName = { fg = mocha.red },
          NeotestPassed = { fg = mocha.green },
          NeotestFailed = { fg = mocha.red },
          NeotestRunning = { fg = mocha.yellow },
          NeotestSkipped = { fg = mocha.teal },
          NeotestDir = { fg = mocha.teal },
          NeotestFile = { fg = mocha.peach },
          NeotestNamespace = { fg = mocha.mauve },
          NeotestIndent = { fg = mocha.surface2 },
          NeotestExpandMarker = { fg = mocha.surface2 },
          -- NeotestFocused = { bg = mocha.surface0, fg = mocha.text },
        }
      end,
    },
  },
}
