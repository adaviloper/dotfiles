local M = {}

M.move_focused_client_fraction = function(start_frac, width_frac)
    local c = client.focus
    if not c then return end

    local padding = 32
    local g = c.screen.workarea -- the visible part of the screen (without bars)
    local available_width = g.width
    local available_height = g.height - (padding * 2)

    local start_xs = {
        ["0"] = padding,
        ["1/6"] = math.floor(available_width / 6) + padding / 2,
        ["1/4"] = math.floor(available_width / 4) + padding,
        ["1/3"] = math.floor(available_width / 3) + padding / 2,
        ["1/2"] = math.floor(available_width / 2) + padding / 2,
        ["3/4"] = math.floor(available_width * 3 / 4) + padding / 2,
        ["2/3"] = math.floor(available_width * 2 / 3) + padding / 2,
    }
    local start_widths = {
        ["1/4"] = math.floor(available_width) / 4 - padding,
        ["1/2"] = math.floor(available_width) / 2 - padding,
        ["3/4"] = math.floor(3 * (available_width - padding) / 4),
        ["1/3"] = math.floor(available_width - padding) / 3, - padding,
        ["2/3"] = math.floor(2 * (available_width - padding) / 3),
    }

    -- Calculate target width and start, based on already shrunk area
    local target_width = start_widths[width_frac]
    local target_x = start_xs[start_frac]

    -- Apply geometry
    c:geometry({
        x = math.floor(target_x),
        y = math.floor(g.y + padding),
        width = math.floor(target_width),
        height = math.floor(available_height)
    })

    c:raise()
end

return M
