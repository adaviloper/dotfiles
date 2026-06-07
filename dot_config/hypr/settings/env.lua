-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("PATH", os.getenv("HOME") .. "/.config/bin:" .. (os.getenv("PATH") or "/usr/local/bin:/usr/bin:/bin"))
hl.env("XCURSOR_SIZE", "16")
hl.env("HYPRCURSOR_SIZE", "16")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
