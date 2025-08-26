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
            -- Trim any trailing newline and get absolute target path
            local target_path = vim.fn.system({ "chezmoi", "target-path", path }):gsub("%s+$", "")
            if target_path == "" then
              vim.notify("chezmoi target-path returned empty string", vim.log.levels.WARN)
              return
            end

            -- Stat the path to check if it's a directory
            local stat = vim.loop.fs_stat(target_path)
            if not stat then
              vim.notify("chezmoi target-path does not exist: " .. target_path, vim.log.levels.WARN)
              return
            end

            local success, err
            if stat.type == "directory" then
              -- Use vim.loop.fs_rmdir for empty dirs, or shell out to `rm -r` for non-empty
              success, err = os.execute(string.format('rm -rf "%s"', target_path))
            else
              -- Delete file
              success, err = os.remove(target_path)
            end

            if not success then
              vim.notify("Failed to delete chezmoi target: " .. (err or "unknown error"), vim.log.levels.ERROR)
            else
              vim.notify("Deleted chezmoi target: " .. target_path)
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
        },
        l = "open",
      }
    }
  }
}
