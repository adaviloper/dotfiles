return {
  'rmagatti/auto-session',
  enabled = false,
  config = function()
    require("auto-session").setup({
      log_level = "error",
      auto_restore_enabled = true,
      auto_save_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Code", "~/Downloads", "/"},
      auto_session_use_git_branch = true,
    })
  end
}
