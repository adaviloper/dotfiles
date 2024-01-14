-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/options.lua
-- Add any additional options here
vim.opt.autoread = true
vim.opt.relativenumber = true -- sets vim.opt.relativenumber
vim.opt.number = true -- sets vim.opt.number
vim.opt.scrolloff = 8
vim.opt.showtabline = 0
vim.opt.spell = true -- sets vim.opt.spell
vim.opt.spelloptions = 'camel'
vim.opt.signcolumn = "yes:1" -- sets vim.opt.signcolumn to auto
vim.opt.whichwrap = 'b,s,<,>'
vim.opt.wrap = true -- sets vim.opt.wrap

vim.g.mapleader = ' '            -- sets vim.g.mapleader
vim.g.maplocalleader = ','       -- set default local leader key
vim.g.autoformat_enabled = false -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
vim.g.autopairs_enabled = true   -- enable autopairs at start
vim.g.cmp_enabled = true         -- enable completion at start
vim.g.diagnostics_mode = 1       -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
vim.g.icons_enabled = true       -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
vim.g.inlay_hints_enabled = true
vim.g.resession_enabled = false
vim.g.ui_notifications_enabled = true -- disable notifications when toggling UI elements
