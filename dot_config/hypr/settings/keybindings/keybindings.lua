require('settings.keybindings.submaps.moom')
require('settings.keybindings.submaps.noctalia')

-- Helpers
--- @param app App
local function focus_or_open(app)
  return function()
    local windows = hl.get_windows({ class = app.class })
    if #windows > 0 then
      table.sort(windows, function(a, b) return (a.focus_history_id or math.huge) < (b.focus_history_id or math.huge) end)
      hl.dispatch(hl.dsp.focus({ window = windows[1] }))
    else
      hl.exec_cmd(app.cmd)
    end
  end
end

local peek_state = {}
local PEEK_Y = math.floor(mon_h * 7 / 8)

local function peek_show()
  local all = hl.get_windows()
  if #all == 0 then return end
  for _, w in ipairs(all) do
    table.insert(peek_state, { addr = w.address, x = w.at.x, y = w.at.y })
    hl.dispatch(hl.dsp.focus({ window = w }))
    hl.dispatch(hl.dsp.window.move({ x = w.at.x, y = PEEK_Y, relative = false }))
  end
end

local function peek_restore()
  local all = hl.get_windows()
  for _, entry in ipairs(peek_state) do
    for _, w in ipairs(all) do
      if w.address == entry.addr then
        hl.dispatch(hl.dsp.focus({ window = w }))
        hl.dispatch(hl.dsp.window.move({ x = entry.x, y = entry.y, relative = false }))
        break
      end
    end
  end
  peek_state = {}
end

-- System / UI
_launcher_pending = false
hl.bind(mainMod .. " + SPACE", function()
  _launcher_pending = true
  hl.exec_cmd(menu.cmd)
end)
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd(shellPrefix .. " window-switcher"))
hl.bind(mainMod .. " + GRAVE", hl.dsp.exec_cmd(shellPrefix .. " window-switcher"))
hl.bind(mainMod .. " + SHIFT + COMMA", hl.dsp.exec_cmd(shellPrefix .. " settings-toggle"))
hl.bind(hyper .. " + S", hl.dsp.exec_cmd(shellPrefix .. " panel-toggle session"))
hl.bind(hyper .. " + D", hl.dsp.exec_cmd(shellPrefix .. " desktop-widgets-toggle-edit"))
hl.bind(hyper .. " + C", hl.dsp.exec_cmd(shellPrefix .. " panel-toggle clipboard"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("cliphist store"))
hl.bind("SUPER + SHIFT + CONTROL + 4", hl.dsp.exec_cmd('grim -g "$(slurp)" - | satty -f -'))
hl.bind("SUPER + SHIFT + CONTROL + 5", hl.dsp.exec_cmd('wf-recorder -g "$(slurp)" -f ~/Videos/recording.mp4'))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(fileManager.cmd))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + D", function()
  if #peek_state > 0 then peek_restore() else peek_show() end
end)

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + TAB", function()
  local all = hl.get_windows()
  if #all < 2 then return end
  table.sort(all, function(a, b) return (a.focus_history_id or math.huge) < (b.focus_history_id or math.huge) end)
  hl.dispatch(hl.dsp.focus({ window = all[2] }))
end)

-- Cycle through windows of the same class as the focused window
hl.bind(mainMod .. " + SHIFT + GRAVE", function()
  local all = hl.get_windows()
  if #all < 2 then return end
  table.sort(all, function(a, b) return (a.focus_history_id or math.huge) < (b.focus_history_id or math.huge) end)
  local focused = all[1]
  local same = {}
  for _, w in ipairs(all) do
    if w.class == focused.class then table.insert(same, w) end
  end
  if #same < 2 then return end
  hl.dispatch(hl.dsp.focus({ window = same[2] }))
end)

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- App launching (Meh = Ctrl + Alt + Shift)
hl.bind(meh .. " + Return", focus_or_open(terminal))
hl.bind(meh .. " + B", focus_or_open(browser))
hl.bind(meh .. " + C", focus_or_open(emailClient))
hl.bind(meh .. " + D", focus_or_open(chat))
hl.bind(meh .. " + E", hl.dsp.exec_cmd("toggle_audio"))
hl.bind(meh .. " + R", focus_or_open(api_client))
hl.bind(meh .. " + T", focus_or_open(database))
hl.bind(meh .. " + X", focus_or_open(passwordManager))

-- Workspaces / scratchpad
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(shellPrefix .. " panel-toggle launcher"))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
