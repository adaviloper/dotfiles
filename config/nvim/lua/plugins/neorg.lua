local neorg_templates = require("helpers.neorg_templates")

return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  dependencies = {
    { "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } },
  },
  config = function(_, _)
    local load = {
      ["core.defaults"] = {},

      ["core.concealer"] = {
        config = {
          folds = true,
          -- icon_preset = 'varied'
        },
      },

      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Code/notes/",
          },
        },
      },

      ["core.integrations.treesitter"] = {},

      ["core.looking-glass"] = {},

      ["core.qol.toc"] = {
        config = {
          auto_toc = {
            open = vim.fn.fnamemodify(vim.fn.expand('%'), ":t") ~= '.dotfiles',
          },
        },
      },

      ["core.ui"] = {},

      ["external.templates"] = {
        config = {
          keywords = {
            MONDAY_DATE = function() return neorg_templates.weekdate(2) end,
            TUESDAY_DATE = function() return neorg_templates.weekdate(3) end,
            WEDNESDAY_DATE = function() return neorg_templates.weekdate(4) end,
            THURSDAY_DATE = function() return neorg_templates.weekdate(5) end,
            FRIDAY_DATE = function() return neorg_templates.weekdate(6) end,
            SATURDAY_DATE = function() return neorg_templates.weekdate(7) end,
            SUNDAY_DATE = function() return neorg_templates.weekdate(8) end,

            CARRYOVER_TODOS = function() return require("luasnip").text_node(neorg_templates.get_carryover_todos()) end,

            FILE_NAME_TITLE_CASE = function ()
              local name = vim.fn.fnamemodify(vim.fn.expand('%'), ':t:r')

              return require("luasnip").text_node(require('helpers.str_utils').title_case(name))
            end
          },
          snippets_overwrite = {},
        },
      },
    }

    require("neorg").setup({ load = load })

    neorg_templates.template("*/journal/*index.norg", "weekly", ".*/journal/%d%d%d%d/%d%d/w%d%d/index.norg")
    neorg_templates.template("*/journal/*.norg", "daily", ".*/journal/%d%d%d%d/%d%d/w%d%d/%d%d%.norg")
    neorg_templates.template("*/people/*.norg", "person")
  end,
}
