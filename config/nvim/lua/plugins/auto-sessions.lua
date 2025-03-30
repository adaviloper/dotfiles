return {
  'rmagatti/auto-session',
  lazy = false,
  enabled = false,
  config = function()
    require("auto-session").setup({
      log_level = "error",
      auto_restore_enabled = true,
      auto_save_enabled = true,
      auto_session_use_git_branch = true,
      auto_restore_lazy_delay_enabled = true,
      silent_restore = true,

      -- auto_session_enable_last_session = true,
      -- auto_session_last_session_dir = '',
      --
      -- auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
      -- auto_session_enabled = true,
      -- -- the configs below are lua only
      -- bypass_session_save_file_types = nil
    })
  end
}
