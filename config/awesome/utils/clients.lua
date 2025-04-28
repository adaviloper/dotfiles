local naughty = require('naughty')

local M = {}

M.is_app_open = function(app_class)
  for _, c in ipairs(client.get()) do
    if c.class == app_class then return true end
  end

  return false
end

M.get_client = function(app_class)
  for _, c in ipairs(client.get()) do
    if c.class == app_class then return c end
  end

  return nil
end

M.launch_app = function(app_class)
  if M.is_app_open(app_class) then
    local c = M.get_client(app_class)
    if c ~= nil then
      client.focus = c
      c:raise()
    end
  else
    naughty.notify({
      title = app_class .. " is not open",
    })
    awful.spawn(terminal)
  end
end

return M
