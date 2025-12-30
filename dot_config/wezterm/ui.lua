local M = {}

function M.setup(config)
  config.adjust_window_size_when_changing_font_size = false
  config.color_scheme = 'Catppuccin Mocha'
  config.enable_tab_bar = false
  config.enable_wayland = false
  config.line_height = 1.0
  config.window_close_confirmation = 'AlwaysPrompt'
  config.window_decorations = 'RESIZE'
end

return M
