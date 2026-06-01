local hyper = "SUPER + CONTROL + ALT + SHIFT" -- debug: using ALT only while testing

local function moom(x_frac, w_frac, y_frac, h_frac)
  return function()
    local g = moom_geo(x_frac, w_frac, y_frac, h_frac)
    hl.dispatch(hl.dsp.window.resize({ x = g.w, y = g.h, relative = false }))
    hl.dispatch(hl.dsp.window.move({ x = g.x, y = g.y, relative = false }))
  end
end

local function nudge(x_bump, y_bump)
  local x_delta = GAP * x_bump
  local y_delta = GAP * y_bump
  return function()
    hl.dispatch(hl.dsp.window.move({
      x = x_delta,
      y = y_delta,
      relative = true,
    }))
  end
end

local function once(fn)
  return function()
    fn()
    hl.dispatch(hl.dsp.submap("reset"))
  end
end

hl.bind(hyper .. " + M", hl.dsp.submap("moom"))

hl.define_submap("moom", function()
  -- Row 1 (Q–T): halves and quarters
  hl.bind("Q", once(moom(0, 1 / 2))) -- left half
  hl.bind("W", once(moom(1 / 4, 1 / 4))) -- 2nd quarter
  hl.bind("E", once(moom(1 / 6, 2 / 3))) -- center 2/3
  hl.bind("R", once(moom(1 / 2, 1 / 4))) -- 3rd quarter
  hl.bind("T", once(moom(1 / 2, 1 / 2))) -- right half

  -- Row 2 (A–G): wider layouts
  hl.bind("A", once(moom(0, 1 / 4))) -- 1st quarter
  hl.bind("S", once(moom(0, 3 / 4))) -- left 3/4
  hl.bind("D", once(moom(1 / 4, 1 / 2))) -- center half
  hl.bind("F", once(moom(1 / 4, 3 / 4))) -- 2nd–4th quarters
  hl.bind("G", once(moom(3 / 4, 1 / 4))) -- 4th quarter

  -- Row 3 (Z–B): thirds
  hl.bind("Z", once(moom(0, 1 / 3))) -- left third
  hl.bind("X", once(moom(0, 2 / 3))) -- left two thirds
  hl.bind("C", once(moom(1 / 3, 1 / 3))) -- center third
  hl.bind("V", once(moom(1 / 3, 2 / 3))) -- right two thirds
  hl.bind("B", once(moom(2 / 3, 1 / 3))) -- right third

  hl.bind("LEFT", nudge(-1, 0))
  hl.bind("RIGHT", nudge(1, 0))
  hl.bind("UP", nudge(0, -1))
  hl.bind("DOWN", nudge(0, 1))

  hl.bind("Escape", hl.dsp.submap("reset"))
end)
