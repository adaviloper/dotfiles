-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

mainMod = "SUPER" -- Sets "Windows" key as main modifier
workspaceMod = "SUPER + CONTROL" -- Sets "Windows" key as main modifier
meh = "CONTROL + ALT + SHIFT" -- debug: using ALT only while testing
hyper = "SUPER + CONTROL + ALT + SHIFT" -- debug: using ALT only while testing

GAP = 32
INNER = GAP / 2
BAR_TOP = GAP
BAR_SIDE = GAP / 4
mon_w = 5120
mon_h = 1440

function moom_geo(x_frac, w_frac, y_frac, h_frac)
  y_frac = y_frac or 0
  h_frac = h_frac or 1
  local at_left   = x_frac          <= 1e-9
  local at_right  = x_frac + w_frac >= 1 - 1e-9
  local at_top    = y_frac          <= 1e-9
  local at_bottom = y_frac + h_frac >= 1 - 1e-9
  local left   = BAR_SIDE + GAP
  local top    = BAR_TOP  + GAP
  local usable_w  = mon_w - 2 * (BAR_SIDE + GAP)
  local usable_h  = mon_h - (BAR_TOP + GAP) - (BAR_SIDE + GAP)
  return {
    x = left + math.floor(x_frac * usable_w) + (at_left   and 0 or INNER),
    y = top  + math.floor(y_frac * usable_h) + (at_top    and 0 or INNER),
    w = math.floor(w_frac * usable_w) - (at_left  and 0 or INNER) - (at_right  and 0 or INNER),
    h = math.floor(h_frac * usable_h) - (at_top   and 0 or INNER) - (at_bottom and 0 or INNER),
  }
end

function once(fn)
  return function()
    fn()
    hl.dispatch(hl.dsp.submap("reset"))
  end
end

function notify(opts)
  local title = opts.title or "Title"
  local body = opts.body or "Body"
  local type = opts.type or "notify"
  hl.dispatch(hl.dsp.exec_cmd("qs -c noctalia-shell ipc call toast send '{\"title\": \""..title.. "\",\"body\": \""..body.. "\",\"type\": \""..opts.type.. "\"}'"))
end

function info(opts)
  opts.type = "notify"
  notify(opts)
end

function warn(opts)
  opts.type = "warning"
  notify(opts)
end

function err(opts)
  opts.type = "error"
  notify(opts)
end

------------------
---- MONITORS ----
------------------

require('settings.monitors')

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
browser   = { class = "zen-browser",                  cmd = "zen" }
terminal   = { class = "com.mitchellh.ghostty",       cmd = "ghostty" }
fileManager = { class = "dolphin",                    cmd = "dolphin" }
swiftpoint = { class = "Swiftpoint X1 Control Panel", cmd = "bash -c 'cd ~/.local/opt/swiftpoint-x1 && \"./Swiftpoint X1 Control Panel\"'" }
chat       = { class = "vesktop",                     cmd = "vesktop --wayland" }
menu       = { class = nil,                           cmd = "qs -c noctalia-shell ipc call launcher toggle" }
passwordManager = { class = "proton-pass",            cmd = "proton-pass" }
database   = { class = "jetbrains-datagrip",          cmd = "/opt/datagrip/bin/datagrip" }
api_client = { class = "apidog",                      cmd = "/opt/apidog/apidog" }

-------------------
---- AUTOSTART ----
-------------------

require('settings.autostart')

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

require('settings.env')

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

require('settings.config.general')

require('settings.config.decoration')

require('settings.config.animations')

require('settings.config.input')

----------------
----  MISC  ----
----------------

require('settings.config.misc')

---------------
---- INPUT ----
---------------

require('settings.config.input')

---------------------
---- KEYBINDINGS ----
---------------------

require('settings.keybindings.keybindings')

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

require('settings.window_rules')

require('settings.layer_rules')

hl.on("hyprland.start", function()
  hl.exec_cmd("bash -c 'dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user restart xdg-desktop-portal && systemctl --user start xdg-desktop-portal-hyprland'")
end)
