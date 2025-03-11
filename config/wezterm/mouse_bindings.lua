local wezterm = require('wezterm')
local action = wezterm.action
local M = {}

function M.setup(config)
  config.mouse_bindings = {
    -- {
    --   event = { Up = { streak = 1, button = 'Left' } },
    --   mods = 'NONE',
    --   action = action.CompleteSelection('ClipboardAndPrimarySelection'),
    -- },

    -- {
    --   event = { Up = { streak = 1, button = 'Left' } },
    --   mods = 'CTRL',
    --   action = action.OpenLinkAtMouseCursor,
    -- },
  }
end

return M
