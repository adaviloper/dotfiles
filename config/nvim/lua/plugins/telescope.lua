return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { -- add a new dependency to telescope that is our new plugin
      "nvim-telescope/telescope-media-files.nvim",
    },
    -- the first parameter is the plugin specification
    -- the second is the table of options as set up in Lazy with the `opts` key
    config = function(plugin, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local telescopeConfig = require("telescope.config")

      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")
      telescope.setup({
        defaults = {
          hidden = true,
          file_ignore_patterns = {
            "config/alfred/.*",
            "public/.*",
            "./assets/fonts/.*",
          },
          layout_config = {
            prompt_position = 'top',
          },
          path_display = function (opts, path)
            local utils = require("telescope.utils")
            local tail = utils.path_tail(path)
            return string.format("%s -- %s", tail, path)
          end,
          sorting_strategy = 'ascending',
          -- mappings = {
          --   i = {
          --     ["<CR>"] = actions.select_vertical
          --   },
          -- },
        },
        pickers = {
          buffers = {
            path_display = {
              "smart",
            },
          },
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            prompt_prefix = ' '
          },
          git_bcommits = {
            git_command = {
              "git",
              "log",
              -- "--pretty=oneline",
              -- "--abbrev-commit",
              "--date=format:%Y-%m-%d",
              "--pretty=format:%C(auto) %h %ad %s",
              "--follow",
            }
          },
          git_commits = {
            git_command = {
              "git",
              "log",
              -- "--pretty=oneline",
              -- "--abbrev-commit",
              "--date=format:%Y-%m-%d",
              "--pretty=format:%C(auto) %h %ad %s",
              "--follow",
            }
          },
        },
      })

      -- require telescope and load extensions as necessary
      -- local telescope = require "telescope"
      -- telescope.load_extension("harpoon")
      require('telescope').load_extension('luasnip')
    end,
  },
  {
    'adaviloper/telescope-env',
    config = function ()
      require('telescope').load_extension('telescope-env')
    end
  },
  {
    "benfowler/telescope-luasnip.nvim",
    module = "telescope._extensions.luasnip",  -- if you wish to lazy-load
  }
}
