local Snacks = require "snacks"
local ls = require('luasnip')

local M = {}

function format_snippets(available_snippets)
  local items = {}
  for _, snippets in pairs(available_snippets) do
    for _, snippet in ipairs(snippets) do
      if snippet.id == 34 then
        vim.notify('snippets.lua:10: ' .. vim.inspect(snippet.description[1]))
      end
      table.insert(items, {
        text = snippet.trigger .. ': ' .. snippet.description[1] or snippet.trigger,
        key = snippet.trigger,
        value = ls.get_id_snippet(snippet.id),
        id = snippet.id,
      });
    end
  end

  return items
end

function M.view_snippets()
  local available_snippets = ls.available(function (snip)
	  return {
	    id = snip.id,
		  name = snip.name,
		  trigger = snip.trigger,
		  description = snip.description,
		  wordTrig = snip.wordTrig and true or false,
		  regTrig = snip.regTrig and true or false,
	  }
  end)
  Snacks.picker.pick({
    source = "snippets",
    items = format_snippets(available_snippets),
    format = "text",
    layout = {
      preview = false,
      layout = {
        height = 0.3,
        max_width = 60,
      },
    },
    confirm = function (picker, item)
      vim.notify('snippets.lua:27: ' .. vim.inspect(item.trigger))
      picker:close()
      ls.snip_expand(item.value)
      vim.cmd('norm a')
    end,
  })
end

return M
