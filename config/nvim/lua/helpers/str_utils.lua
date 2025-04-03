local M = {}

function firstToUpper(str) return (str:lower():gsub("^%l", string.upper)) end

function M.title_case(str)
  local name_parts = {}

  str = strip_special_characters(str)

  for _, part in ipairs(vim.split(str, " ")) do
    table.insert(name_parts, firstToUpper(part))
  end

  return table.concat(name_parts, " ")
end

function strip_special_characters(str)
  local special_characters = { "_", "-", "'" }
  str = str:gsub("^%s*", ''):gsub("%s*$", '')

  for _, character in ipairs(special_characters) do
    str = str:gsub(character, " ")
  end

  return str
end

function M.slug(str)
  str = strip_special_characters(str):gsub(" ", "-"):lower()

  return str
end

function M.snake(str)
  str = strip_special_characters(str):gsub("-", "_")

  return str
end

return M
