local M = {}

M.move_focused_client_fraction = function(start_frac, width_frac)
    local c = client.focus
    if not c then return end

    local g = c.screen.workarea -- the visible part of the screen (without bars)
    local available_width = g.width - padding
    local available_height = g.height - padding - menu_offset - (padding * 2)

    -- Calculate target width and start, based on already shrunk area
    local target_width = available_width * width_frac - padding
    local target_x = start_frac * available_width + padding

    -- Apply geometry
    c:geometry({
        x = math.floor(target_x),
        y = math.floor(g.y + 2 * padding + menu_offset),
        width = math.floor(target_width),
        height = math.floor(available_height)
    })

    c:raise()
end

return M
