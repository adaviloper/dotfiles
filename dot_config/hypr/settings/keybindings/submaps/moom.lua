local function has_tag(win, tag)
  if not win.tags then return false end
  for _, t in ipairs(win.tags) do
    if t == tag then return true end
  end
  return false
end

local function place_window(win, geo)
  hl.dispatch(hl.dsp.focus({ window = win }))
  hl.dispatch(hl.dsp.window.resize({ x = geo.w, y = geo.h, relative = false }))
  hl.dispatch(hl.dsp.window.move({ x = geo.x, y = geo.y, relative = false }))
end

local function moom(x_frac, w_frac, y_frac, h_frac)
  return function()
    local g = moom_geo(x_frac, w_frac, y_frac, h_frac)
    hl.dispatch(hl.dsp.window.resize({ x = g.w, y = g.h, relative = false }))
    hl.dispatch(hl.dsp.window.move({ x = g.x, y = g.y, relative = false }))
  end
end

local function resize(x_bump, y_bump)
  local x_delta = GAP * x_bump
  local y_delta = GAP * y_bump
  return function()
    hl.dispatch(hl.dsp.window.resize({ x = x_delta, y = y_delta, relative = true }))
    reset_debounce_timer()
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
    reset_debounce_timer()
  end
end

hl.bind(hyper .. " + M", function()
  hl.dispatch(hl.dsp.submap("moom"))
  reset_debounce_timer()
end)

hl.define_submap("moom", function()
  -- Row 1 (Q–T): halves and quarters
  hl.bind("Q", with_debounce(moom(0, 1 / 2))) -- left half
  hl.bind("W", with_debounce(moom(1 / 4, 1 / 4))) -- 2nd quarter
  hl.bind("E", with_debounce(moom(1 / 6, 2 / 3))) -- center 2/3
  hl.bind("R", with_debounce(moom(1 / 2, 1 / 4))) -- 3rd quarter
  hl.bind("T", with_debounce(moom(1 / 2, 1 / 2))) -- right half

  -- Row 2 (A–G): wider layouts
  hl.bind("A", with_debounce(moom(0, 1 / 4))) -- 1st quarter
  hl.bind("S", with_debounce(moom(0, 3 / 4))) -- left 3/4
  hl.bind("D", with_debounce(moom(1 / 4, 1 / 2))) -- center half
  hl.bind("F", with_debounce(moom(1 / 4, 3 / 4))) -- 2nd–4th quarters
  hl.bind("G", with_debounce(moom(3 / 4, 1 / 4))) -- 4th quarter

  -- Row 3 (Z–B): thirds
  hl.bind("Z", with_debounce(moom(0, 1 / 3))) -- left third
  hl.bind("X", with_debounce(moom(0, 2 / 3))) -- left two thirds
  hl.bind("C", with_debounce(moom(1 / 3, 1 / 3))) -- center third
  hl.bind("V", with_debounce(moom(1 / 3, 2 / 3))) -- right two thirds
  hl.bind("B", with_debounce(moom(2 / 3, 1 / 3))) -- right third

  hl.bind("SPACE", with_debounce(moom(0, 1))) -- full screen
  hl.bind("Return", with_debounce(function() hl.dispatch(hl.dsp.window.center()) end)) -- center window
  hl.bind("CTRL + Return", with_debounce(function() hl.dispatch(hl.dsp.window.fullscreen()) end)) -- center window

  hl.bind("LEFT", nudge(-1, 0), { repeating = true })
  hl.bind("RIGHT", nudge(1, 0), { repeating = true })
  hl.bind("UP", nudge(0, -1), { repeating = true })
  hl.bind("DOWN", nudge(0, 1), { repeating = true })

  hl.bind("ALT + LEFT", resize(-4, 0), { repeating = true })
  hl.bind("ALT + RIGHT", resize(4, 0), { repeating = true })
  hl.bind("ALT + UP", resize(0, 4), { repeating = true })
  hl.bind("ALT + DOWN", resize(0, -4), { repeating = true })

  hl.bind("SHIFT + LEFT", nudge(-4, 0), { repeating = true })
  hl.bind("SHIFT + RIGHT", nudge(4, 0), { repeating = true })
  hl.bind("SHIFT + UP", nudge(0, -4), { repeating = true })
  hl.bind("SHIFT + DOWN", nudge(0, 4), { repeating = true })

  -- Layout presets
  hl.bind("P", with_debounce(function()
    local wins = hl.get_windows()
    if #wins == 0 then return end
    table.sort(wins, function(a, b) return (a.focus_history_id or math.huge) < (b.focus_history_id or math.huge) end)
    local win = wins[1]
    if win.class == browser.class then
      hl.dispatch(hl.dsp.window.tag({ window = win, tag = "primary" }))
    end
  end))

  hl.bind("J", with_debounce(function()
    local browsers = hl.get_windows({ class = browser.class })
    local terminals = hl.get_windows({ class = terminal.class })
    local emailClients = hl.get_windows({ class = emailClient.class })

    local primary, secondary
    for _, w in ipairs(browsers) do
      if has_tag(w, "primary") then
        primary = w
      else
        secondary = w
      end
    end
    -- Fallback to focus-history order if nothing is tagged
    if not primary then
      table.sort(browsers, function(a, b) return (a.focus_history_id or math.huge) < (b.focus_history_id or math.huge) end)
      primary = browsers[1]
      secondary = browsers[2]
    end

    if secondary then place_window(secondary, moom_geo(3 / 4, 1 / 4)) end
    if #emailClients >= 1 then place_window(emailClients[1], moom_geo(1 / 4, 1 / 2)) end
    if #terminals >= 1 then place_window(terminals[1], moom_geo(1 / 4, 1 / 2)) end
    if primary then place_window(primary, moom_geo(1 / 4, 1 / 2)) end
  end))

  hl.bind("K", with_debounce(function()
    local browsers = hl.get_windows({ class = browser.class })
    local terminals = hl.get_windows({ class = terminal.class })
    local emailClients = hl.get_windows({ class = emailClient.class })

    local primary, secondary
    for _, w in ipairs(browsers) do
      if has_tag(w, "primary") then
        primary = w
      else
        secondary = w
      end
    end
    -- Fallback to focus-history order if nothing is tagged
    if not primary then
      table.sort(browsers, function(a, b) return (a.focus_history_id or math.huge) < (b.focus_history_id or math.huge) end)
      primary = browsers[1]
      secondary = browsers[2]
    end

    if secondary then place_window(secondary, moom_geo(3 / 4, 1 / 4)) end
    if #emailClients >= 1 then place_window(emailClients[1], moom_geo(1 / 4, 1 / 2)) end
    if primary then place_window(primary, moom_geo(1 / 4, 1 / 2)) end
    if #terminals >= 1 then place_window(terminals[1], moom_geo(1 / 4, 1 / 2)) end
  end))

  hl.bind("M", with_debounce(function()
    local browsers = hl.get_windows({ class = browser.class })
    local chat = hl.get_windows({ class = chat.class })
    local terminals = hl.get_windows({ class = terminal.class })
    local emailClients = hl.get_windows({ class = emailClient.class })

    local primary
    for _, w in ipairs(browsers) do
      if has_tag(w, "primary") then primary = w end
    end
    -- Fallback to most recently focused browser
    if not primary and #browsers >= 1 then
      table.sort(browsers, function(a, b) return (a.focus_history_id or math.huge) < (b.focus_history_id or math.huge) end)
      primary = browsers[1]
    end

    if #chat >= 1 then place_window(chat[1], moom_geo(0, 1 / 4)) end
    if #emailClients >= 1 then place_window(emailClients[1], moom_geo(1 / 3, 5 / 12)) end
    if primary then place_window(primary, moom_geo(0, 1 / 3)) end
    if #terminals >= 1 then place_window(terminals[1], moom_geo(1 / 3, 5 / 12)) end
  end))

  hl.bind("Escape", function()
    cancel_debounce_timer()
    hl.dispatch(hl.dsp.submap("reset"))
  end)
end)
