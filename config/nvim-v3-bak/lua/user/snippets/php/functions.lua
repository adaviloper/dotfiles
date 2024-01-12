return
  -- Autosnippets
  {
    -- Anonymous closure
    s('func',
      fmt(
        [[
function() {{
    {}
}}
    ]], {
          i(1, '')
        })),
    -- Anonymous closure with use
    s('ufunc',
      fmt(
        [[
function() use (${}) {{
    {}
}}
    ]], {
          i(1, '$var'),
          i(2, ''),
        })),
  },
  -- Autosnippets
  {

  }
