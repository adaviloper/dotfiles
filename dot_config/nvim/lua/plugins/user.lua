local mocha = require("catppuccin.palettes").get_palette("mocha")
local Snacks = require("snacks")

-- You can also add new plugins here as well using the lazy syntax:
return {
  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- customize alpha options
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- customize the dashboard header

      vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = mocha.blue })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = mocha.green, bg = mocha.blue })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo2_1", { fg = mocha.blue, bg = mocha.green })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = mocha.green })
      vim.api.nvim_set_hl(0, "NeovimDashboardFooter1", { fg = mocha.blue })
      vim.api.nvim_set_hl(0, "NeovimDashboardFooter2", { fg = mocha.green })
      opts.dashboard.preset.header = table.concat({
        [[     ██        ]],
        [[    ███        ]],
        [[   ███        ]],
        [[  ██████████  ]],
        [[    ██   ██  ]],
        [[      ██    ██  ]],
        [[      ██   ██  ]],
        [[     ███████  ]],
        [[      █        ]],
        [[]],
        [[N  E  O  V  I  M]],
      }, "\n")

      -- opts.dashboard = {
      --   { { 'NeovimDashboardLogo1', 2, 45 } },
      --   { { 'NeovimDashboardLogo1', 2, 45 } },
      --   { { 'NeovimDashboardLogo1', 2, 45 } },
      --   { { 'NeovimDashboardLogo3', 2, 14 }, { 'NeovimDashboardLogo1', 14, 20 }, { 'NeovimDashboardLogo3', 20, 45 } },
      --   { { 'NeovimDashboardLogo1', 2, 17 }, { 'NeovimDashboardLogo3', 18, 41 } },
      --   { { 'NeovimDashboardLogo1', 2, 19 }, { 'NeovimDashboardLogo3', 16, 45 } },
      --   { { 'NeovimDashboardLogo1', 2, 19 }, { 'NeovimDashboardLogo3', 15, 45 } },
      --   { { 'NeovimDashboardLogo3', 0, 45 } },
      --   { { 'NeovimDashboardLogo1', 0, 45 } },
      --   {},
      --   { { 'NeovimDashboardFooter1', 0, 8 }, { 'NeovimDashboardFooter2', 9, 22 } },
      -- }
      -- 

      opts.dashboard.sections = {
        { section = 'header' },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            {
              icon = " ",
              title = "Git Status",
              cmd = "git --no-pager status --short",
              height = 10,
            },
            {
              icon = " ",
              title = "Open PRs",
              cmd = "gh pr list -L 3 -a adaviloper",
              key = "P",
              action = function()
                vim.fn.jobstart("gh pr list --web", { detach = true })
              end,
              height = 4,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              -- pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = { 0, 1 },
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
        { section = 'startup', padding = 1 },
      }

      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require("astronvim.plugins.configs.nvim-autopairs")(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex("%%"))
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex("xx"))
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    'echasnovski/mini.icons',
    opts = {
      extension = {
        php = {  glyph = '' },
      },
    }
  }
}
