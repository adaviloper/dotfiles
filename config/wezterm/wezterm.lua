local wezterm = require('wezterm')
local act = wezterm.action
local config = {}

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('JetBrainsMono Nerd Font', {
  weight = 'Regular',
})
config.font_size = 16.0
config.enable_tab_bar = false
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_decorations = 'RESIZE'

config.keys = {
  {
    key = 's',
    mods = 'CMD',
    action = act.Multiple({
      act.SendKey({ key = ' ', mods = 'CTRL' }),
      act.SendKey({ key = 'T' }),
    })
  }
}

return config
