return
  -- Autosnippets
  {
    -- Public function 
    s('pubf',
      sn(
        1,
        fmt(
          [[
public function {}() {{
{}
}}
]],
          {
            i(1, 'method_name')
          }
        )
      )
    ),
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
