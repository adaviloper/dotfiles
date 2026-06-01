hl.config({
    cursor = {
        no_warps = true,
    },
})

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },

        follow_mouse = 2,

        mouse_refocus = false,
    },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})
