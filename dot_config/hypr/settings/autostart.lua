-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
  hl.exec_cmd("bash -c 'for d in /run/user/$UID/hypr/*/; do name=\"${d%/}\"; name=\"${name##*/}\"; hyprctl -i \"$name\" version &>/dev/null || rm -rf \"$d\"; done'")
  hl.exec_cmd("systemctl --user unset-environment HYPRLAND_INSTANCE_SIGNATURE")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland")
  hl.exec_cmd(browser.cmd)
  hl.exec_cmd(terminal.cmd)
  hl.exec_cmd(emailClient.cmd)
  hl.exec_cmd(chat.cmd)
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("systemctl --user start noctalia")
  -- hl.exec_cmd("bash -c '~/.config/eww/launch_eww'")
  hl.exec_cmd("xwaylandvideobridge")
  hl.exec_cmd("bash -c 'sleep 3 && cd ~/.local/opt/swiftpoint-x1 && \"./Swiftpoint X1 Control Panel\"'")
  hl.exec_cmd("bash -c 'dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user restart xdg-desktop-portal && systemctl --user start xdg-desktop-portal-hyprland'")
end)

hl.on("window.active", function()
  local all = hl.get_windows()
  if #all < 2 then return end

  table.sort(all, function(a, b) return (a.focus_history_id or math.huge) < (b.focus_history_id or math.huge) end)

  local focused = all[1]
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top", window = focused }))
end)

