return {
  opt = { -- vim.opt.<key>
    autoread = true,
    breakindentopt = 'shift:2',
    conceallevel = 2,
    jumpoptions = 'view',
    number = true,
    relativenumber = true,
    scrolloff = 8,
    signcolumn = "yes:1", -- set to 1 to prevent horizontal jumping
    showtabline = 0,
    spell = true,
    spelloptions = "camel",
    whichwrap = "b,s,<,>",
    wildmode = 'list:longest,full',
    wrap = true,
  },
  g = { -- vim.g.<key>
    -- configure global vim variables (vim.g)
    -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
    -- This can be found in the `lua/lazy_setup.lua` file
    autoformat_enabled = false,
    autopairs_enabled = true,
    cmp_enabled = true,
    format_on_save = false,
    icons_enabled = true,
    resession_enabled = false,
    ui_notifications_enabled = false, -- disable notifications when toggling UI elements
  },
}
