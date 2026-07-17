-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
  persistent_size = true,
})

hl.window_rule({
  name = "take-focus",
  match = { class = browser.class },

  focus_on_activate = true,
})

hl.window_rule({
  name = "force 16:9",
  match = { class = "Slay the Spire 2" },

  keep_aspect_ratio = true,
})

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
  [api_client.class]        = moom_geo(1/4, 1/2),
  [chat.class]              = moom_geo(0,   1/4),
  [database.class]          = moom_geo(1/4, 1/2),
  [emailClient.class]       = moom_geo(1/4, 1/2),
  [notes_app.class]         = moom_geo(1/4, 1/2),
  [passwordManager.class]   = moom_geo(0,   1/4),
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
      hl.dispatch(hl.dsp.window.tag({ window = window, tag = "primary" }))
    else
      g = moom_geo(3/4, 1/4) -- second+ browser: right quarter
    end
  elseif is_swiftpoint(window.class) then
    hl.dispatch(hl.dsp.window.center({ window = window}))
    return
  elseif window.class == fileManager.class then
    hl.dispatch(hl.dsp.window.resize({ x = 1400, y = 900, relative = false }))
    hl.dispatch(hl.dsp.window.center({ window = window }))
    return
  else
    g = placements[window.class]
  end

  if not g then return end
  hl.dispatch(hl.dsp.window.resize({ x = g.w, y = g.h, relative = false }))
  hl.dispatch(hl.dsp.window.move({ x = g.x, y = g.y, relative = false }))
end)

hl.on("window.active", function()
  local active = hl.get_active_window()
  if not active then return end
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top", window = active }))
end)

-- Fullscreen windows move to a dedicated workspace that never shows the Noctalia bar
local FULLSCREEN_WS = "name:fullscreen"local fullscreen_origin = {}

hl.on("window.fullscreen", function(window)
  if not window then return end

  if window.fullscreen ~= 0 then
    if window.workspace then
      fullscreen_origin[window.address] = window.workspace.id
    end
    hl.dispatch(hl.dsp.window.move({ window = window, workspace = FULLSCREEN_WS }))
    hl.dispatch(hl.dsp.focus({ workspace = FULLSCREEN_WS }))
  else
    local origin = fullscreen_origin[window.address]
    fullscreen_origin[window.address] = nil
    if origin then
      hl.dispatch(hl.dsp.window.move({ window = window, workspace = origin }))
      hl.dispatch(hl.dsp.focus({ workspace = origin }))

      local g = placements[window.class]
      if g then
        -- Hyprland's own pre-fullscreen geometry restore lands a tick after
        -- this event fires and clobbers any reposition issued right here,
        -- so defer reapplying the placement until that reflow has settled.
        local restore_timer
        restore_timer = hl.timer(function()
          hl.dispatch(hl.dsp.window.resize({ window = window, x = g.w, y = g.h, relative = false }))
          hl.dispatch(hl.dsp.window.move({ window = window, x = g.x, y = g.y, relative = false }))
          restore_timer:set_enabled(false)
        end, { timeout = 50, type = "oneshot" })
      end
    end
  end
end)

hl.on("workspace.active", function(workspace)
  if not workspace then return end
  hl.exec_cmd(workspace.name == "fullscreen" and "noctalia msg bar-hide default" or "noctalia msg bar-show default")
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
