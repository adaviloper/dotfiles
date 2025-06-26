local awful = require('awful')
local naughty = require('naughty')

local M = {}

M.client_mapping = {
  terminal = {
    class = "org.wezfurlong.wezterm",
    name = "wezterm",
  },
  browser = {
    class = "firefox_firefox",
    name = "firefox"
  },
}

M.is_app_open = function(app_class)
  for _, c in ipairs(client.get()) do
    if c.class == app_class.class then return true end
  end

  return false
end

M.get_client = function(app)
  for _, c in ipairs(client.get()) do
    if c.class == app.class then return c end
  end

  return nil
end

M.launch_app = function(app)
  if M.is_app_open(M.client_mapping[app]) then
    local c = M.get_client(M.client_mapping[app])
    if c ~= nil then
      client.focus = c
      c:raise()
    end
  else
    awful.spawn(M.client_mapping[app].name)
  end
end

return M
