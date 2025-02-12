local collection_pipeline = function (parent, method)
  return fmt(
    [[
      {}->]] .. method .. [[(function (${}) {{
          return ${};
      }})
      ]],
    {
      t(parent.env.POSTFIX_MATCH),
      t(parent.env.POSTFIX_MATCH),
      t(parent.env.POSTFIX_MATCH),
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
