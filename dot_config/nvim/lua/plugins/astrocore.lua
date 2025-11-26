local utils = require("helpers.utils")

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = false,
      virtual_lines = {
        current_line = true,
      },
      underline = true,
    },
    -- vim options can be configured here
    options = require('config.options'),
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = require('config.mappings'),

    sessions = {
      -- disable the auto-saving of directory sessions
      autosave = {
        last = true,
        cwd = true,
      },
    },

    autocmds = {
      active_cursor_line = {
        {
          event = { "WinEnter", "BufEnter" },
          callback = function ()
            vim.opt_local.cursorline = true
          end,
        },
        {
          event = { "WinLeave", "BufLeave" },
          callback = function ()
            vim.opt_local.cursorline = false
          end,
        },
      },

      apply_chez_moi_edits = {
        {
          event = "BufWritePost",
          desc = "Apply Chez Moi edits after saving a buffer",
          callback = function()
            local path = vim.fn.expand("%:p")

            if path:find("/.local/share/chezmoi/") then

              vim.schedule(function()
                vim.notify("chezmoi source change detected")
                vim.fn.jobstart({ "chezmoi", "apply", "-P", "--source-path", vim.fn.expand("%:p:.") }, {
                  stdout_buffered = true,
                  on_stdout = function(_, data)
                    if data then
                      vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
                    end
                  end,
                })
              end)
            end
          end
        },
      },

      git_branch_sessions = {
        -- auto save directory sessions on leaving
        {
          event = "VimLeavePre",
          desc = "Save git branch directory sessions on close",
          callback = vim.schedule_wrap(function()
            if require("astrocore.buffer").is_valid_session() then
              require("resession").save(
                utils.get_session_name(),
                {
                  -- dir = "dirsession",
                  notify = false,
                }
              )
            end
          end),
        },

        -- auto restore previous previous directory session, remove if necessary
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          nested = true, -- trigger other autocommands as buffers open
          callback = function()
            -- Only load the session if nvim was started with no args
            if vim.fn.argc(-1) == 0 then
              -- try to load a directory session using the current working directory
              require("resession").load(
                utils.get_session_name(),
                {
                  silence_errors = true,
                }
              )
            end
          end,
        },
      },

      change_session_on_branch_change = {
        {
          event = 'User',
          pattern = 'GitBranchChange',
          callback = function()
            require('resession').load(
              utils.get_session_name(),
              {
                  silence_errors = true,
              }
            )
          end,
        }
      }
    },
  },
}
