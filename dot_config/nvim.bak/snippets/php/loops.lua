local camel_case = function (args)
  local letters = vim.split(args[1][1], '')
  if #letters == 0 then
    return ''
  end
  if string.find(args[1][1], 'Request') then
    return '$request'
  end
  letters[1] = string.lower(letters[1])
  return '$' .. table.concat(letters, '')
end

local collection_pipeline = function (parent, method)
  return fmt(
    [[
      {}->]] .. method .. [[(function ({} {}) {{
          return {};
      }})
      ]],
    {
      t(parent.env.POSTFIX_MATCH),
      i(1, ''),
      f(
        camel_case,
        {1}
      ),
      f(
        camel_case,
        {1}
      ),
    }
  )
end


return
  {
    postfix(
      {
        trig = '.filter',
        -- matchTSNode = {
        --   query = [[
        --     [
        --       (variable_name)
        --     ] @prefix
        --   ]],
        --   query_lang = 'php'
        -- },
      },
      d(
        1,
        function (_, parent)
          return sn(
            nil,
            collection_pipeline(parent, 'filter')
          )
        end,
        {}
      )
    ),
    postfix(
      {
        trig = '.map',
        -- matchTSNode = {
        --   query = [[
        --     [
        --       (variable_name)
        --     ] @prefix
        --   ]],
        --   query_lang = 'php'
        -- },
      },
      d(
        1,
        function (_, parent)
          return sn(
            nil,
            collection_pipeline(parent, 'map')
          )
        end,
        {}
      )
    ),
  },
  {}
