local mocha = require("catppuccin.palettes").get_palette("mocha")

return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")
    local grapple = require('grapple')
    local conditions = require('heirline.conditions')

    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode({
        -- enable mode text with padding as well as an icon before it
        mode_text = {
          icon = { kind = "VimIcon", padding = { right = 1, left = 0 } },
          padding = { right = 0, left = 0 },
        },
        -- surround the component with a separators
        surround = {
          -- it's a left element, so use the left separator
          separator = "left",
          -- set the color of the surrounding based on the current mode using astronvim.utils.status module
          color = function()
            return { main = status.hl.mode_bg() }
          end,
        },
      }),
      status.component.git_branch(),
      status.component.file_info({
        provider = function (self)
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
          if grapple.exists() and grapple.name_or_index() ~= nil then
            return '[' .. grapple.name_or_index() .. ']'
          end
        end
      }),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info({
        macro_recording = {
          icon = { kind = "MacroRecording", padding = { right = 1 } },
          hl = { fg = mocha.red },
        },
      }),
      status.component.fill(),
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
      status.component.mode({ surround = { separator = "blank" } }),
    }

    opts.winbar = nil

    opts.tabline = { -- tabline
      { -- file tree padding
        condition = function(self)
          self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
          return status.condition.buffer_matches(
            { filetype = { "aerial", "dapui_.", "neo%-tree", "NvimTree" } },
            vim.api.nvim_win_get_buf(self.winid)
          )
        end,
        provider = function(self)
          return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1)
        end,
        hl = { bg = "tabline_bg" },
      },


      status.component.file_info({
        hl = { fg = mocha.text },
        filename = {
          modify = ':t',
        },
        filetype = false,
        -- file_modified = true,
        -- file_read_only = true,
        surround = {
          separator = 'tab',
          color = mocha.surface0,
        },
      }),
      status.component.fill({ hl = { bg = "tabline_bg" } }), -- fill the rest of the tabline with background color
      { -- tab list
        condition = function()
          return #vim.api.nvim_list_tabpages() >= 2
        end, -- only show tabs if there are more than one
        status.heirline.make_tablist({ -- component for each tab
          provider = status.provider.tabnr(),
          hl = function(self)
            return status.hl.get_attributes(
              status.heirline.tab_type(self, "tab"),
              true
            )
          end,
        }),
        { -- close button for current tab
          provider = status.provider.close_button({
            kind = "TabClose",
            padding = { left = 1, right = 1 },
          }),
          hl = status.hl.get_attributes("tab_close", true),
          on_click = {
            callback = function()
              require("astroui.buffer").close_tab()
            end,
            name = "heirline_tabline_close_tab_callback",
          },
        },
      },
    }

    opts.statuscolumn = { -- statuscolumn
      -- Adds indent level
      -- init = function(self)
      --   self.bufnr = vim.api.nvim_get_current_buf()
      -- end,
      status.component.foldcolumn(),
      status.component.numbercolumn(),
      status.component.signcolumn(),
    }
  end,
}
