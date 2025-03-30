return {
  "princejoogie/dir-telescope.nvim",
  enabled = false,
  -- telescope.nvim is a required dependency
  requires = {"nvim-telescope/telescope.nvim"},
  config = function()
    require("dir-telescope").setup({
      -- these are the default options set
      hidden = false,
      no_ignore = false,
      show_preview = true,
    })
    require('telescope').load_extension('dir')
  end,
}
