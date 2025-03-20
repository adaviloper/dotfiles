return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = function(_, _)
    require('neorg').setup({
      load = {
        ['core.defaults'] = {},

        ['core.concealer'] = {
          config = {
            folds = true,
            -- icon_preset = 'varied'
          },
        },
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/Code/notes/'
            },
          },
        },
        ['core.integrations.treesitter'] = {},
        ['core.looking-glass'] = {},
        ['core.qol.toc'] = {
          config = {
            auto_toc = {
              open = true,
            },
          },
        },
        ['core.ui'] = {},
      }
    })
  end,
}
