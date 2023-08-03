---@diagnostic disable: missing-parameter
return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      window = {
        position = 'float',
      }
    },
  }
}
