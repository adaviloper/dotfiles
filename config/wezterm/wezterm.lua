local keybindings = require('keybindings')
local font = require('font')
local ui = require('ui')
local config = {}

for _, value in pairs({keybindings, font, ui}) do
  value.setup(config)
end

return config
