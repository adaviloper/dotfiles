return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
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
