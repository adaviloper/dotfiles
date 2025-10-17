local neorg_templates = require("helpers.neorg_templates")
local ls = require('luasnip')
local t = ls.text_node
local c = ls.choice_node

return {
  "nvim-neorg/neorg",
  -- lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  ft = "norg",
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
          icons = {
            heading = {
              icons = {
                "◉",
                " ◎",
                "  ○",
                "   ✺",
                "    ▶",
                "     ⤷",
              },
            },
            list = {
              icons = {
                " •",
                "  •",
                "   •",
                "    •",
                "     •",
                "      •",
              },
            },
            ordered = {
              icons = {
                "1.",
                " A.",
                "  a.",
                "   (1)",
                "    I.",
                "     i.",
              },
            },
          },
        },
      },

      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = vim.env.HOME .. "/Code/neorg/notes/",
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
          templates_dir = vim.env.HOME .. '/Code/neorg/templates',
          keywords = {
            MONDAY_DATE = function() return neorg_templates.weekdate(2) end,
            TUESDAY_DATE = function() return neorg_templates.weekdate(3) end,
            WEDNESDAY_DATE = function() return neorg_templates.weekdate(4) end,
            THURSDAY_DATE = function() return neorg_templates.weekdate(5) end,
            FRIDAY_DATE = function() return neorg_templates.weekdate(6) end,
            SATURDAY_DATE = function() return neorg_templates.weekdate(7) end,
            SUNDAY_DATE = function() return neorg_templates.weekdate(8) end,

            CARRYOVER_TODOS = function() return ls.text_node(neorg_templates.get_carryover_todos()) end,

            INSERT_2 = function() return ls.insert_node(1) end,
            INSERT_3 = function() return ls.insert_node(1) end,
            INSERT_4 = function() return ls.insert_node(1) end,

            FILE_NAME_TITLE_CASE = function ()
              local name = vim.fn.fnamemodify(vim.fn.expand('%'), ':t:r')

              return ls.text_node(require('helpers.str_utils').title_case(name))
            end,

            APPLICATION_STATUS = c(1, { t("applied"), t("rejected") }),
            TICKET_TYPE = c(1, { t("story"), t("bug"), t("task") }),
          },
          snippets_overwrite = {},
        },
      },
    }

    require("neorg").setup({ load = load })

    neorg_templates.template("*/job-search/companies/*.norg", "company")
    neorg_templates.template("*/journal/*.norg", "daily", ".*/journal/%d%d%d%d/%d%d/w%d%d/%d%d%.norg")
    neorg_templates.template("*/journal/*index.norg", "weekly", ".*/journal/%d%d%d%d/%d%d/w%d%d/index.norg")
    neorg_templates.template("*/meetings/*.norg", "meeting", ".*/meetings/%d%d%d%d/.*%.norg")
    neorg_templates.template("*/meetings/one-on-one/*.norg", "one-on-one", ".*/meetings/one%-on%-one/.*.norg")
    neorg_templates.template("*/miscellaneous/*.norg", "miscellaneous")
    neorg_templates.template("*/people/*.norg", "person")
    neorg_templates.template("*/tickets/*.norg", "ticket")
  end,
}
