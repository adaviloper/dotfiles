hl.config({
  general = {
    extend_border_grab_area = 8,
    gaps_in = GAP / 2,
    gaps_out = GAP,

    border_size = 2,

    col = {
      active_border = { colors = { mocha.mauve }, angle = 45 },
      inactive_border = surface2,
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = true,
    hover_icon_on_border = true,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing = false,

    layout = "master",
  },
})
