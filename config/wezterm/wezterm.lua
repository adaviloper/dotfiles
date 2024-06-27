local keybindings = require('keybindings')
local font = require('font')
local ui = require('ui')
local hooks = require("hooks")
local config = {}

for _, value in pairs({keybindings, font, ui, hooks}) do
  value.setup(config)
end

config.term = "wezterm"

return config
