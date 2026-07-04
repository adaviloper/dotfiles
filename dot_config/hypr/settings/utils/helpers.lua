function moom_geo(x_frac, w_frac, y_frac, h_frac)
  y_frac = y_frac or 0
  h_frac = h_frac or 1
  local at_left   = x_frac          <= 1e-9
  local at_right  = x_frac + w_frac >= 1 - 1e-9
  local at_top    = y_frac          <= 1e-9
  local at_bottom = y_frac + h_frac >= 1 - 1e-9
  local left   = BAR_SIDE + GAP
  local top    = BAR_TOP  + GAP
  local usable_w  = mon_w - 2 * (BAR_SIDE + GAP)
  local usable_h  = mon_h - (BAR_TOP + GAP) - (BAR_SIDE + GAP)
  return {
    x = left + math.floor(x_frac * usable_w) + (at_left   and 0 or INNER),
    y = top  + math.floor(y_frac * usable_h) + (at_top    and 0 or INNER),
    w = math.floor(w_frac * usable_w) - (at_left  and 0 or INNER) - (at_right  and 0 or INNER),
    h = math.floor(h_frac * usable_h) - (at_top   and 0 or INNER) - (at_bottom and 0 or INNER),
  }
end

function once(fn)
  return function()
    fn()
    hl.dispatch(hl.dsp.submap("reset"))
  end
end

local _debounce_timer

_debounce_timer = hl.timer(function()
  hl.dispatch(hl.dsp.submap("reset"))
  _debounce_timer:set_enabled(false)
end, { timeout = 1500, type = "repeat" })
_debounce_timer:set_enabled(false)

function reset_debounce_timer()
  _debounce_timer:set_enabled(false)
  _debounce_timer:set_enabled(true)
end

function cancel_debounce_timer()
  _debounce_timer:set_enabled(false)
end

function with_debounce(fn)
  return function()
    fn()
    reset_debounce_timer()
  end
end

function notify(opts)
  local title = opts.title or "Title"
  local body = opts.body or "Body"
  local type = opts.type or "notify"
  hl.dispatch(hl.dsp.exec_cmd("qs -c noctalia-shell ipc call toast send '{\"title\": \""..title.. "\",\"body\": \""..body.. "\",\"type\": \""..opts.type.. "\"}'"))
end

function info(opts)
  opts.type = "notify"
  notify(opts)
end

function warn(opts)
  opts.type = "warning"
  notify(opts)
end

function err(opts)
  opts.type = "error"
  notify(opts)
end
