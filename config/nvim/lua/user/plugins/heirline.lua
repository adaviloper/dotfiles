return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astronvim.utils.status")
    opts.statusline = {
      -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        -- enable mode text with padding as well as an icon before it
        mode_text = {
          icon = {
            kind = "VimIcon",
            padding = {
              right = 1,
            }
          },
          padding = {
            right = 1,
            left = 1
          },
        },
        -- surround the component with a separators
        surround = {
          -- it's a left element, so use the left separator
          separator = "left",
          -- set the color of the surrounding based on the current mode using astronvim.utils.status module
          color = function() return { main = status.hl.mode_bg(), right = "terminal" } end,
        },
      },
      status.component.git_branch {
        surround = {
          separator = "left",
          color = function() return { main = "terminal", right = "file_info_bg" } end,
        },
        padding = {
          right = 1,
          left = 1
        },
      },
      status.component.file_info {
        file_icon = {
          padding = {
            left = 1,
            right = 1,
          }
        },
        padding = {
          right = 1,
          left = 1
        },
        file_modified = false,
        color = function() return { main = "file_info_bg", right = "git_diff_bg" } end,
      },
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.treesitter(),
      status.component.nav(),
    }

    return opts
  end,
}
