return {
  "nvim-neo-tree/neo-tree.nvim",
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
    buffers = {
      follow_current_file = { enabled = true },
    },
    enable_git_status = true,
    window = {
      mappings = {
        J = {
          function ()
            vim.cmd('norm 5j')
          end
        },
        K = {
          function ()
            vim.cmd('norm 5k')
          end
        }
      }
    }
  }
}
