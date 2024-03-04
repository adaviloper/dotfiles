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
          d(3, function (_)
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
    {}
    return{};
}}
                  ]], {
                    i(1, 'return_value'),
                    i(2, ''),
                    f(
                      function (return_value_args)
                        local key = return_value_args[1][1]
                        if return_types[key] == nil then
                          return ''
                        end
                        if key == 'void' then
                          return return_types[key]
                        end
                        return ' ' .. return_types[key]
                      end,
                      {1}
                    ),
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
    s('__construct',
      fmt(
        [[
        public function __construct({})
        {{
            {}
        }}
        ]],
        {
          i(1, ''),
          i(2, ''),
        }
      )
    ),
    s('__call',
      fmt(
        [[
        public function __call({})
        {{
            {}
        }}
        ]],
        {
          i(1, ''),
          i(2, ''),
        }
      )
    ),
  },
  -- Autosnippets
  {

  }
