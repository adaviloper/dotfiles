local mocha = require("catppuccin.palettes").get_palette("mocha")

local function get_ft_hl()
	local ft_color = {
		css = mocha.blue,
		json = mocha.text,
		lua = mocha.sky,
		markdown = mocha.yellow,
		php = mocha.mauve,
		scss = mocha.red,
		toml = mocha.red,
		typescript = mocha.blue,
		vue = mocha.green,
	}

	return ft_color[vim.bo.filetype] or mocha.green
end

return {
	"rebelot/heirline.nvim",
	opts = function(_, opts)
		local status = require("astroui.status")
		local grapple = require("grapple")
		local conditions = require("heirline.conditions")

		opts.statusline = { -- statusline
			hl = { fg = "fg", bg = mocha.base },
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
			status.component.git_branch(
				{
					surround = {
						color = function()
							return {
								main = mocha.mauve,
							}
						end,
					},
					hl = {
						fg = mocha.base,
					}
				}
			),
			status.component.file_info({
				provider = function(self)
					-- first, trim the pattern relative to the current directory. For other
					-- options, see :h filename-modifers
					local filename = vim.fn.fnamemodify(self.filename, ":.")

					if filename == "" then
						return "[No Name]"
					end
					-- now, if the filename would occupy more than 1/4th of the available
					-- space, we trim the file path to its initials
					-- See Flexible Components section below for dynamic truncation
					if not conditions.width_percent_below(#filename, 0.25) then
						filename = vim.fn.pathshorten(filename)
					end
					if grapple.exists() and grapple.name_or_index() ~= nil then
						return "[" .. grapple.name_or_index() .. "]"
					end
				end,
			}),
			status.component.git_diff({
				surround = {
					color = {
						main = mocha.mantle,
					},
				},
			}),
			status.component.diagnostics(),
			status.component.fill(),
			status.component.cmd_info({
				macro_recording = {
					icon = { kind = "MacroRecording", padding = { right = 1 } },
					hl = { fg = mocha.red },
				},
			}),
			{ -- tab list
				condition = function()
					return #vim.api.nvim_list_tabpages() >= 2
				end, -- Only show tabs if there are more than one
				status.heirline.make_tablist({ -- component for each tab
					provider = status.provider.tabnr(),
					hl = function(self)
						local is_active_tab = status.heirline.tab_type(self, "tab") == 'tab_active'
						if is_active_tab then
							-- return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true)
							return {
								bg = mocha.base,
								fg = get_ft_hl()
							}
						end
						return {
							bg = mocha.mantle,
						}
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
			status.component.fill(),
			status.component.lsp({
				hl = function ()
					return { fg = get_ft_hl() }
				end,
				surround = { separator = "tab" }
			}),
			status.component.virtual_env(),
			status.component.treesitter({ surround = { separator = "tab" } }),
			status.component.nav(),
			status.component.mode({ surround = { separator = "blank" } }),
		}

		opts.winbar = { -- create custom winbar
      -- store the current buffer number
      init = function(self)
        self.bufnr = vim.api.nvim_get_current_buf()
      end,
      fallthrough = false, -- pick the correct winbar based on condition
      -- inactive winbar
      {
        condition = function()
          return not status.condition.is_active()
        end,
        -- add the file name and icon
				status.component.file_info({
					hl = { fg = mocha.text },
					file_icon = { padding = { left = 0 } },
					filename = {
						modify = ":p:.",
					},
					filetype = false,
					-- file_modified = true,
					-- file_read_only = true,
					surround = {
						separator = "tab",
						color = mocha.base,
						condition = status.condition.is_file
					},
				}),
      },
      -- active winbar
      {
        -- add the file name and icon
				status.component.file_info({
					hl = function ()
						return { fg = get_ft_hl() }
					end,
					file_icon = { padding = { left = 0 } },
					filename = {
						modify = ":p:.",
					},
					filetype = false,
					-- file_modified = true,
					-- file_read_only = true,
					surround = {
						separator = "tab",
						color = mocha.surface0,
						condition = status.condition.is_file,
					},
				}),
      },
    }

		-- Disabling tabline in `options.lua`
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
				hl = { fg = mocha.green },
				filename = {
					modify = ":p:.",
				},
				filetype = false,
				-- file_modified = true,
				-- file_read_only = true,
				surround = {
					separator = "tab",
					color = mocha.surface0,
					condition = status.condition.is_file,
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
						return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true)
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
