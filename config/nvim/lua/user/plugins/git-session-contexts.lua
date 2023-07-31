return {
  dir = "./git-session-contexts",
  lazy = false,
  config = function()
    local M = {}

    -- Routes calls made to this module to functions in the
    -- plugin's other modules.
    checkout_branch = function (pattern)
      vim.notify(pattern)
      require("telescope.builtin").git_branches({
        layout_strategy="vertical",
        layout_config={
          width=0.5
        }
      })
    end
    -- M.insert_todo = function ()
    --   vim.notify("inserting todos")
    -- end
    -- M.complete_todo = function ()
    --   vim.notify("completing todos")
    -- end

    vim.api.nvim_create_user_command(
      "Gco",
      function(opts)
        checkout_branch(opts.args)
      end,
      {
        nargs = '?'
      }
    )
    -- vim.api.nvim_create_user_command("InsertTodos", function() M.insert_todos() end, {})
    -- vim.api.nvim_create_user_command("UpdateTodos", function() M.complete_todo() end, {})

    return M
        
  end,
}

