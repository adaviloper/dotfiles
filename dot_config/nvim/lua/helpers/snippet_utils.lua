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

return M

