local tmux = require('keybindings.tmux')

local M = {}

function M.setup(config)
  config.keys = {}

  local groups = {
    tmux
  }

  for _, group in ipairs(groups) do
    local bindings = group.getKeybindings()
    for _, binding in ipairs(bindings) do
      table.insert(config.keys, binding)
    end
  end
end

return M
