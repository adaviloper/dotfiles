local M = {}

function M.setup(config)
  config.color_scheme = 'Catppuccin Mocha'
  config.enable_tab_bar = false
  config.line_height = 1.0
  config.window_close_confirmation = 'AlwaysPrompt'
  config.window_decorations = 'RESIZE'
end

return M
