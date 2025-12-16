local Snacks = require "snacks"
local ls = require('luasnip')
local snippet_utils = require("helpers.snippet_utils")

local M = {}

function format_snippets(available_snippets)
  local items = {}
  for _, snippets in pairs(available_snippets) do
    for _, snippet in ipairs(snippets) do
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
  Snacks.picker.pick({
    source = "snippets",
    items = format_snippets(snippet_utils.available_snippets()),
    format = "text",
    layout = {
      preview = false,
      layout = {
        height = 0.3,
        max_width = 60,
      },
    },
    confirm = function (picker, item)
      picker:close()
      ls.snip_expand(item.value)
      vim.cmd('norm a')
    end,
  })
end

return M
