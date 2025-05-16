local str_utils = require("helpers.str_utils")
local ls = require('luasnip')
local sn = ls.sn
local c = ls.c
local t = ls.t

local M = {}

function M.camelize_var(args, _)
    local text = args[1][1] or ""
    local camel_str = str_utils.camel(text)
    return sn(nil, {
      c(1, {
        t(camel_str)
        })
      })
end

return M

