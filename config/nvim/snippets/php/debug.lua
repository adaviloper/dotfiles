return
  -- Autosnippets
  {
    -- Public function 
    s('dml',
      fmt(
        [[
dd({}__METHOD__ . ':' . __LINE__);
    ]], {
          i(1, ''),
        })),
    s('ll',
      fmt(
        [[
Log::{}({});
    ]], {
          c(1, {t('info'), t('debug')}),
          i(2, ''),
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

