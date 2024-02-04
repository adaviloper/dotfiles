local function file_exists(file)
  if vim.fn.filereadable(file) ~= 1 then return nil end
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    if line ~= '' then
      lines[#lines + 1] = line
    end
  end
  return lines
end

return
  -- Snippets
  {
    s('test',
      fmt(
        'public function {}(){}',
        {
          i(1, 'method_name'),
          d(2, function (args)
            local lines = lines_from(vim.fn.expand('%'))
            --- @param line string
            for k, line in pairs(lines) do
              if line:match('class') then
                return sn(nil, fmt(
                  [[
                  : {}
                  {{
                      {}
                  }}
                  ]], {
                    i(1, 'return_value'),
                    i(2, ''),
                  }
                ))
              end
              if line:match('interface ') then
                return sn(nil, t(';'))
              end
            end
          end)
        }
      )
    ),
    -- Public function 
    s('pubf',
      fmt(
        [[
public function {}(): {}
{{
    {}
}}
    ]], {
          i(1, 'method_name'),
          i(2, ''),
          i(3, ''),
        })),
    -- Private function
    s('prif',
      fmt(
        [[
private function {}(): {}
{{
    {}
}}
    ]], {
          i(1, 'method_name'),
          i(2, ''),
          i(3, ''),
        })),
    s('pubsf',
      fmt(
        [[
public static function {}(): {}
{{
    {}
}}
    ]], {
          i(1, 'method_name'),
          i(2, ''),
          i(3, ''),
        })),
    s('prisf',
      fmt(
        [[
public static function {}(): {}
{{
    {}
}}
    ]], {
          i(1, 'method_name'),
          i(2, ''),
          i(3, ''),
        })),
  },
  -- Autosnippets
  {

  }
