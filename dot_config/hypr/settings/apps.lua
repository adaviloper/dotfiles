--- @class App
--- @field class string
--- @field cmd string
-- Set programs that you use
--
--- @type App
browser         = { class = "zen-browser",                 cmd = "zen" }
--- @type App
terminal        = { class = "com.mitchellh.ghostty",       cmd = "ghostty" }
--- @type App
fileManager     = { class = "thunar",             cmd = "thunar" }
--- @type App
swiftpoint      = { class = "Swiftpoint X1 Control Panel", cmd = "bash -c 'cd ~/.local/opt/swiftpoint-x1 && \"./Swiftpoint X1 Control Panel\"'" }
--- @type App
chat            = { class = "vesktop",                     cmd = "vesktop --wayland" }
--- @type App
menu            = { class = nil,                           cmd = "noctalia msg panel-toggle launcher" }
--- @type App
passwordManager = { class = "Proton Pass",                 cmd = "proton-pass" }
--- @type App
emailClient     = { class = "Proton Mail",                 cmd = "proton-mail" }
--- @type App
database        = { class = "jetbrains-datagrip",          cmd = "/opt/datagrip/bin/datagrip" }
--- @type App
api_client      = { class = "apidog",                      cmd = "/opt/apidog/apidog" }

shellPrefix = "noctalia msg"

