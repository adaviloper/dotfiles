local keybindings = require("keybindings")
local mouse_bindings = require("mouse_bindings")
local font = require("font")
local ui = require("ui")
local hooks = require("hooks")
local config = {}

local handle = io.popen('uname -s')
op_sys = ""
if handle then
  result = handle:read("*a")
  op_sys = string.gsub(result, '^%s*(.-)%s*$', '%1')
  handle:close()
end

for _, category in pairs({
	hooks,
	keybindings,
	mouse_bindings,
	font,
	ui,
}) do
	category.setup(config)
end

config.term = "wezterm"

return config
