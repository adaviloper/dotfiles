local wezterm = require('wezterm')
local M = {}

function M.setup(config)
  local is_jb = false
  local font = 'Maple Mono NF'

  -- Some comment
  if is_jb then
    font = 'JetBrainsMono Nerd Font'
  end

  config.font = wezterm.font(font, {
    weight = 'Regular',
  })

  if op_sys == "Linux" then
    config.font_size = 13.1
  else
    config.font_size = 16.0
  end
end

return M
