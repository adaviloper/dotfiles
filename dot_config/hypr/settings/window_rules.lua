-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },

  no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

hl.window_rule({
  match = { class = ".*" },
  float = true,
})

-- Per-app placement: fires after window rules (including float) are applied
local placements = {
  [chat.class]              = moom_geo(0,   1/4),
  [passwordManager.class]   = moom_geo(0,   1/4),
  [emailClient.class]       = moom_geo(1/4, 1/2),
  [database.class]          = moom_geo(1/4, 1/2),
  [api_client.class]        = moom_geo(1/4, 1/2),
  [terminal.class]          = moom_geo(1/4, 1/2),
  -- ["Swiftpoint X1 Control Panel"] = moom_geo(),
}

local function is_browser(class)
  return class == browser.class
end

local function is_swiftpoint(class)
  return class == swiftpoint.class
end

local function other_browser_count(window)
  local count = 0
  for _, w in ipairs(hl.get_windows()) do
    if is_browser(w.class) and w.address ~= window.address then
      count = count + 1
    end
  end
  return count
end

hl.on("window.open", function(window)
  if not window then return end

  local g
  if is_browser(window.class) then
    if other_browser_count(window) == 0 then
      g = moom_geo(1/4, 1/2) -- first browser: center half
    else
      g = moom_geo(3/4, 1/4) -- second+ browser: right quarter
    end
  elseif is_swiftpoint(window.class) then
    hl.dispatch(hl.dsp.window.center({ window = window}))
    return
  else
    g = placements[window.class]
  end

  if not g then return end
  hl.dispatch(hl.dsp.window.resize({ x = g.w, y = g.h, relative = false }))
  hl.dispatch(hl.dsp.window.move({ x = g.x, y = g.y, relative = false }))
end)

hl.window_rule({
  name = "xwayland-video-bridge-fixes",
  match = { class = "xwaylandvideobridge" },

  no_initial_focus = true,
  no_focus = true,
  no_anim = true,
  no_blur = true,
  max_size = { 1, 1 },
  opacity = 0.0,
})

hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move = "20 monitor_h-120",
  float = true,
})
