-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
  hl.exec_cmd(terminal.cmd)
  hl.exec_cmd(chat.cmd)
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("hyprpaper & zen & qs -c noctalia-shell")
  hl.exec_cmd("xwaylandvideobridge")
  hl.exec_cmd("bash -c 'sleep 3 && cd ~/.local/opt/swiftpoint-x1 && \"./Swiftpoint X1 Control Panel\"'")
end)

hl.on("window.active", function()
  local all = hl.get_windows()
  if #all < 2 then return end

  table.sort(all, function(a, b) return (a.focus_history_id or math.huge) < (b.focus_history_id or math.huge) end)

  local focused = all[1]
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top", window = win }))
end)

