local wezterm = require('wezterm')
local act = wezterm.action

local M = {}

local tmuxPrefix = act.SendKey({ key = ' ', mods = 'CTRL' })

function M.getKeybindings()
  return {
    { -- Switch to previously current window
      key = 'l',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'l' }),
      })
    },
    { -- Session Switching
      key = 's',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'T' }),
      })
    },
    { -- Window 1
      key = '1',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '1' }),
      })
    },
    { -- Window 2
      key = '2',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '2' }),
      })
    },
    { -- Window 3
      key = '3',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '3' }),
      })
    },
    { -- Window 4
      key = '4',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '4' }),
      })
    },
    { -- Window 5
      key = '5',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '5' }),
      })
    },
    { -- Window 6
      key = '6',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '6' }),
      })
    },
    { -- Window 7
      key = '7',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '7' }),
      })
    },
    { -- Window 8
      key = '8',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '8' }),
      })
    },
    { -- Window 9
      key = '9',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '9' }),
      })
    },
  }
end

return M
