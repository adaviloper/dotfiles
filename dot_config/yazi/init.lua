require("git"):setup()

function Linemode:size_and_mtime()
	local year = os.date("%Y")
	local time = math.floor(self._file.cha.mtime or 0)

	if time > 0 and os.date("%Y", time) == year then
		time = os.date("%b %d %H:%M", time)
	else
		time = time and os.date("%b %d  %Y", time) or ""
	end

	local size = self._file:size()
	return ui.Line(string.format(" %s %s ", size and ya.readable_size(size) or "-", time))
end

Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line {}
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		ui.Span(":"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		ui.Span(" "),
	}
end, 500, Status.RIGHT)

function Status:name()
	local h = self._tab.current.hovered
	if not h then
		return ui.Line {}
	end


 	local linked = ""
 	if h.link_to ~= nil then
 		linked = " -> " .. tostring(h.link_to)
 	end
return ui.Line(" " .. h.name .. linked)end
