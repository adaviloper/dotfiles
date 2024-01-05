local wezterm = require('wezterm')
local act = wezterm.action

local M = {}

local tmuxPrefix = act.SendKey({ key = ' ', mods = 'CTRL' })

function M.getKeybindings()
  
  return {
    { -- Tmux Session Switching
      key = 's',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'T' }),
      })
    },
    { -- Tmux Window 1
      key = '1',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '1' }),
      })
    },
    { -- Tmux Window 2
      key = '2',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '2' }),
      })
    },
    { -- Tmux Window 3
      key = '3',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '3' }),
      })
    },
    { -- Tmux Window 4
      key = '4',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '4' }),
      })
    },
    { -- Tmux Window 5
      key = '5',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '5' }),
      })
    },
    { -- Tmux Window 6
      key = '6',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '6' }),
      })
    },
    { -- Tmux Window 7
      key = '7',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '7' }),
      })
    },
    { -- Tmux Window 8
      key = '8',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '8' }),
      })
    },
    { -- Tmux Window 9
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
