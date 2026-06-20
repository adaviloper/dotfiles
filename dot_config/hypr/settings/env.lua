-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("PATH", os.getenv("HOME") .. "/.config/bin:" .. (os.getenv("PATH") or "/usr/local/bin:/usr/bin:/bin"))
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")

hl.env("XCURSOR_THEME", "catppuccin-mocha-lavender-cursors")  -- replace with your color
hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-lavender-cursors")

