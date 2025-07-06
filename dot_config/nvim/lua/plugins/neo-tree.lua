return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    buffers = {
      follow_current_file = { enabled = true },
    },
    enable_git_status = true,
    event_handlers = {
      {
        event = 'before_file_delete',
        handler = function(path)
          if path:find("/.local/share/chezmoi/") then
            -- Run synchronously to get target path before file is deleted
            local target_path = vim.fn.system({ "chezmoi", "target-path", path }):gsub("%s+$", "")

            if target_path ~= "" then
              -- Now delete the target file
              local ok, err = os.remove(target_path)
              if not ok then
                vim.notify("Failed to delete chezmoi target: " .. err, vim.log.levels.ERROR)
              else
                vim.notify("Deleted chezmoi target: " .. target_path)
              end
            else
              vim.notify("chezmoi target-path returned empty result", vim.log.levels.WARN)
            end
          end
        end,
      },
    },
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
