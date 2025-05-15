local M = {}

local gsub = string.gsub
local lower = string.lower
local upper = string.upper

local function trim(str)
  return gsub(str, "^%s*", ''):gsub("%s*$", '')
end

local function strip_special_characters(str)
  local special_characters = { "_", "-", "'" }
  str = trim(str)

  for _, character in ipairs(special_characters) do
    str = gsub(str, character, " ")
  end

  return str
end

local function firstToUpper(str)
  return gsub(lower(str), "^%l", upper)
end

function M.title_case(str)
  local name_parts = {}

  str = strip_special_characters(str)

  for _, part in ipairs(vim.split(str, " ")) do
    table.insert(name_parts, firstToUpper(part))
  end

  return table.concat(name_parts, " ")
end

function M.slug(str)
  str = strip_special_characters(str):gsub(" ", "-"):lower()
  return str
end

function M.snake(str)
  str = strip_special_characters(str):gsub("-", "_"):lower()
  return str
end

function M.camel(str)
  str = strip_special_characters(str)
  return str
    :gsub(" (%w)", function(c) return c:upper() end)
    :gsub("^%u", lower)
end

return M

