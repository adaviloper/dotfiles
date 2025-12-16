local str_utils = require("helpers.str_utils")
local ls = require('luasnip')
local sn = ls.sn
local c = ls.c
local t = ls.t

local M = {}

function M.pascal_case_var(args, _)
  local text = args[1][1] or ""
  return str_utils.pascal(text)
end

function M.camelize_var(args, _)
  local text = args[1][1] or ""
  return str_utils.camel(text)
end

function M.slug_case_var(args, _)
  local text = args[1][1] or ""
  return str_utils.slug(text)
end

function M.title_case_var(args, _)
  local text = args[1][1] or ""
  return str_utils.title_case(text)
end

--- @class Snippet
--- @field id integer
--- @field name string
--- @field trigger string
--- @field description string
--- @field wordTrig string
--- @field regTrig string

--- @return Snippet
function M.available_snippets()
  return ls.available(function (snip)
	  return {
	    id = snip.id,
		  name = snip.name,
		  trigger = snip.trigger,
		  description = snip.description,
		  wordTrig = snip.wordTrig and true or false,
		  regTrig = snip.regTrig and true or false,
	  }
  end)
end

--- @return LuaSnip.Snippet
function M.find_snippet_by_trigger(trigger)
  local target_snippet = nil
  for _, snippets in pairs(M.available_snippets()) do
    for _, snippet in ipairs(snippets) do
      if snippet.trigger == trigger then
        target_snippet = snippet
        break
      end
    end
  end

  if target_snippet == nil then return end

  local id = target_snippet.id
  return ls.get_id_snippet(id)
end

return M

