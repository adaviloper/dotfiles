local wezterm = require('wezterm')
local M = {}

function M.setup(config)
  config.font = wezterm.font('JetBrainsMono Nerd Font', {
    weight = 'Regular',
  })

  if op_sys == "Linux" then
    config.font_size = 13.1
  else
    config.font_size = 16.0
  end
end

return M
