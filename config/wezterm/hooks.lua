local wezterm = require('wezterm')

local M = {}

function M.setup(_)
  wezterm.on(
    'gui-startup',
    function (cmd)
      local active_screen = wezterm.gui.screens()['active']
      local _, _, window = wezterm.mux.spawn_window(cmd or {})

      local padding = 30
      local menu_bar_height = 25

      if active_screen.width > 2560 then
        window:gui_window():set_position((active_screen.width) / 4 + padding, padding + menu_bar_height)
        window:gui_window():set_inner_size((active_screen.width - (padding * 4)) / 2, active_screen.height - (padding * 2) - menu_bar_height)
      else
        window:gui_window():set_position(padding, padding + menu_bar_height)
        window:gui_window():set_inner_size((active_screen.width - padding * 2), active_screen.height - (padding * 2 - menu_bar_height))
      end
    end
  )
end

return M
