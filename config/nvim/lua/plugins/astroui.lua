return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    icons = {
      VimIcon = "",
      ScrollText = "",
      -- Git icons
      GitBranch = "",
      GitAdd = "",
      GitChange = "",
      GitDelete = "",
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
    status = {
      separators = {
        left = { "", " " }, -- separator for the left side of the statusline
        right = { " ", "" }, -- separator for the right side of the statusline
        tab = { "", " " },
        blank = { "", "" },
      },
    },
    text_icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "|",
      LSPLoading2 = "/",
      LSPLoading3 = "-",
      LSPLoading4 = "\\",

      -- configure neotree
      FolderClosed = "+",
      FolderEmpty = "-",
      FolderOpen = "-",
    },
  },
}
