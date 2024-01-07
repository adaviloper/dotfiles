return
  -- Autosnippets
  {
    -- Public function 
    s('dml',
      fmt(
        [[
dd(__METHOD__ . ':' . __LINE__, {});
    ]], {
          i(1, ''),
        })),
    -- Private function
--     s('prif',
--       fmt(
--         [[
-- private function {}()
-- {{
--     {}
-- }}
--     ]], {
--           i(1, 'method_name'),
--           i(2, ''),
--         })),
  },
  -- Autosnippets
  {

  }

