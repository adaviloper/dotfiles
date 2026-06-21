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
              -- Only delete files chezmoi manages; leave untracked files alone
              local managed_handle = io.popen(
                string.format('chezmoi managed --path-style=absolute 2>/dev/null | grep -F "%s/"', target_path)
              )
              local del_failed = false
              if managed_handle then
                for managed_file in managed_handle:lines() do
                  local fstat = vim.loop.fs_stat(managed_file)
                  if fstat and fstat.type == "file" then
                    if not os.remove(managed_file) then del_failed = true end
                  end
                end
                managed_handle:close()
              end
              if del_failed then
                vim.notify("Failed to delete some managed files in: " .. target_path, vim.log.levels.WARN)
              end
              -- Only remove the folder if no files (tracked or untracked) remain
              local check_handle = io.popen(string.format('find "%s" -type f 2>/dev/null | wc -l', target_path))
              local file_count = check_handle and tonumber(check_handle:read("*l")) or nil
              if check_handle then check_handle:close() end
              if file_count == 0 then
                success, err = os.execute(string.format('rm -rf "%s"', target_path))
              else
                vim.notify("Skipping folder deletion — untracked files still exist in: " .. target_path, vim.log.levels.WARN)
                success = true
              end
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
