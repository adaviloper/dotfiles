-- vim.api.nvim_create_user_command(
--   "Gco",
--   function(args)
--     local ticket_number = args.fargs[1]
--     require('telescope.builtin').git_branches({ pattern = 'refs/**/*'..ticket_number..'*'})
--   end,
--   {
--     nargs = "+",
--     complete = function()
--       return vim.tbl_keys(commands)
--     end,
--   }
-- )

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { -- add a new dependency to telescope that is our new plugin
    "nvim-telescope/telescope-media-files.nvim",
  },
  -- the first parameter is the plugin specification
  -- the second is the table of options as set up in Lazy with the `opts` key
  config = function(plugin, opts)
    local telescope = require("telescope")
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
        sorting_strategy = 'ascending',
      },
      pickers = {
        buffers = {
          path_display = { "smart" },
        },
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        -- git_commits = {
        --   git_command = { "git", "log", "--format=format:%cs %h %s", "--", "." }
        -- },
      },
    })

    -- require telescope and load extensions as necessary
    -- local telescope = require "telescope"
    -- telescope.load_extension("harpoon")
  end,
}
