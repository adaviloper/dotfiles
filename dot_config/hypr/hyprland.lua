-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

require('settings.utils.modifiers')

require('settings.utils.constants')

require('settings.utils.helpers')

------------------
---- MONITORS ----
------------------

require('settings.monitors')

---------------------
---- MY PROGRAMS ----
---------------------

require('settings.apps')

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
