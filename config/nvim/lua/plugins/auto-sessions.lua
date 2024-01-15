return {
  'rmagatti/auto-session',
  lazy = false,
  config = function()
    require("auto-session").setup({
      log_level = "error",
      auto_restore_enabled = true,
      auto_save_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/"},
      auto_session_use_git_branch = true,
      auto_session_enable_last_session = true,
      auto_session_last_session_dir = '',

      auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
      auto_session_enabled = true,
      -- the configs below are lua only
      bypass_session_save_file_types = nil
    })
  end
}
