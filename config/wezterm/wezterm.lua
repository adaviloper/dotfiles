local keybindings = require("keybindings")
local font = require("font")
local ui = require("ui")
local hooks = require("hooks")
local config = {}

for _, value in pairs({
	hooks,
	keybindings,
	font,
	ui,
}) do
	value.setup(config)
end

config.term = "wezterm"

return config
