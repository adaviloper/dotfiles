-- set vim options here (vim.<first_key>.<second_key> = value)
return {
  opt = {
    autoread = true,
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true,         -- sets vim.opt.number
    scrolloff = 8,
    showtabline = 0,
    spell = true,       -- sets vim.opt.spell
    spelloptions = 'camel',
    signcolumn = 'yes', -- sets vim.opt.signcolumn to auto
    whichwrap = 'b,s,<,>',
    wrap = true,        -- sets vim.opt.wrap
  },
  g = {
    mapleader = ' ',            -- sets vim.g.mapleader
    maplocalleader = ',',       -- set default local leader key
    autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true,         -- enable completion at start
    autopairs_enabled = true,   -- enable autopairs at start
    diagnostics_mode = 1,       -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true,       -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    inlay_hints_enabled = true,
    resession_enabled = false,
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
  },
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = ' '
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end