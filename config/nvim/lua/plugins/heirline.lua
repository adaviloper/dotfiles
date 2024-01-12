return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")
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
          color = function()
            return { main = "terminal", right = "file_info_bg" }
          end,
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
        provider = function(self)
          local grapple = require('grapple')
          local conditions = require('heirline.conditions')
          -- first, trim the pattern relative to the current directory. For other
          -- options, see :h filename-modifers
          local filename = vim.fn.fnamemodify(self.filename, ":.")
          if filename == "" then return "[No Name]" end
          -- now, if the filename would occupy more than 1/4th of the available
          -- space, we trim the file path to its initials
          -- See Flexible Components section below for dynamic truncation
          if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
          end
          if grapple.exists() and grapple.key() ~= nil then
            return '[' .. grapple.key() .. ']'
          end
        end,
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
    opts.winbar = { -- winbar
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      fallthrough = false,
      {
        -- condition = function() return not status.condition.is_active() end,
        status.component.separated_path(),
        status.component.file_info({
          file_icon = { hl = status.hl.file_icon("winbar"), padding = { left = 0 } },
          file_modified = false,
          file_read_only = false,
          hl = status.hl.get_attributes("winbarnc", true),
          surround = false,
          update = "BufEnter",
        }),
      },
      status.component.breadcrumbs({ hl = status.hl.get_attributes("winbar", true) }),
    }

    return opts
  end,
}
