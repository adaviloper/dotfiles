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
  [chat]                    = moom_geo(0,   1/4),
  [database]                = moom_geo(1/4, 1/2),
  [api_client]              = moom_geo(1/4, 1/2),
  ["com.mitchellh.ghostty"] = moom_geo(1/4, 1/2),
}

hl.on("window.open", function(window)
  if not window then return end
  local g = placements[window.class]
  if not g then return end
  hl.dispatch(hl.dsp.window.resize({ x = g.w, y = g.h, relative = false }))
  hl.dispatch(hl.dsp.window.move({ x = g.x, y = g.y, relative = false }))
end)

hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move = "20 monitor_h-120",
  float = true,
})
