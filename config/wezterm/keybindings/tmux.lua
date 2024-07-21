local wezterm = require('wezterm')
local act = wezterm.action

local M = {}

local tmuxPrefix = act.SendKey({ key = ' ', mods = 'CTRL' })

function M.getKeybindings()
  return {
    { -- Switch to Dotfiles session
      key = '.',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = '.' }),
      })
    },
    { -- Switch to Loop session
      key = 'u',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'u' }),
      })
    },
    { -- Switch to Plugins session
      key = 'i',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'i' }),
      })
    },
    { -- Switch to QMK session
      key = 'o',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'o' }),
      })
    },
    { -- Kill current session
      key = 'e',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'q' }),
      })
    },
    { -- Switch to previous window
      key = 'l',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'l' }),
      })
    },
    { -- Switch to previous session
      key = 'h',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'L' }),
      })
    },
    { -- Switch to previously window
      key = 'j',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'n' }),
      })
    },
    { -- Switch to next window
      key = 'k',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'p' }),
      })
    },
    { -- Switch to upper pane
      key = 'UpArrow',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'UpArrow' }),
      })
    },
    { -- Switch to lower pane
      key = 'DownArrow',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'DownArrow' }),
      })
    },
    { -- Switch to left pane
      key = 'LeftArrow',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'LeftArrow' }),
      })
    },
    { -- Switch to right pane
      key = 'RightArrow',
      mods = 'CMD',
      action = act.Multiple({
        tmuxPrefix,
        act.SendKey({ key = 'RightArrow' }),
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
