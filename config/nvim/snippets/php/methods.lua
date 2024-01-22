return
  -- Autosnippets
  {
    -- Public function 
    s('pubf',
      fmt(
        [[
public function {}()
{{
    {}
}}
    ]], {
          i(1, 'method_name'),
          i(2, ''),
        })),
    -- Private function
    s('prif',
      fmt(
        [[
private function {}()
{{
    {}
}}
    ]], {
          i(1, 'method_name'),
          i(2, ''),
        })),
    s('pubsf',
      fmt(
        [[
public static function {}()
{{
    {}
}}
    ]], {
          i(1, 'method_name'),
          i(2, ''),
        })),
    s('prisf',
      fmt(
        [[
public static function {}()
{{
    {}
}}
    ]], {
          i(1, 'method_name'),
          i(2, ''),
        })),
  },
  -- Autosnippets
  {

  }
