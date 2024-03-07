local function file_exists(file)
  if vim.fn.filereadable(file) ~= 1 then return nil end
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local return_types = {
  bool = 'false',
  null = 'null',
  int = '0',
  float = '0.0',
  array = '[]',
}

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

local get_default_return_type = function (return_value_args)
  local key = return_value_args[1][1]
  if key == 'void' then
    return ''
  end
  if return_types[key] == nil then
    return ''
  end
  return {
    '',
    '',
    '    return ' .. return_types[key] .. ';',
  }
end

local determine_method_body = function (_)
  local current_line = vim.api.nvim_get_current_line()
  if string.match(current_line, 'abstract') then
    return sn(nil, t(';'))
  end

  local lines = lines_from(vim.fn.expand('%'))

  --- @param line string
  for _, line in pairs(lines) do
    if line:match('class ') then
      return sn(nil, fmt(
        [[: {}
{{
    {}{}
}}
                  ]], {
          i(1, 'void'),
          i(0, ''),
          f(
            get_default_return_type,
            {1}
          ),
        }
      ))
    end
    if line:match('interface ') then
      return sn(nil, t(';'))
    end
  end
end

return
  -- Snippets
  {
    -- Public function 
    s('meth',
      fmt(
        '{} function {}(){}',
        {
          c(1, { t('public'), t('protected'), t('private') } ),
          i(2, 'method_name'),
          d(3, determine_method_body)
        }
      )
    ),
    s('mcon',
      fmt(
        [[
        public function __construct({})
        {{
            {}
        }}
        ]],
        {
          i(1, ''),
          i(0, ''),
        }
      )
    ),
    s('mcall',
      fmt(
        [[
        public function {}($name, $arguments)
        {{
            {}
        }}
        ]],
        {
          c(1, {
            t('__call'),
            t('__callStatic')
          }),
          i(0, ''),
        }
      )
    ),
  },
  -- Autosnippets
  {

  }
