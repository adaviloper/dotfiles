local callouts = {
  "bug",
  "info",
  "note",
  "question",
  "quote",
  "success",
  "warning",
}

local snippets = {}

for _, callout in ipairs(callouts) do
  table.insert(
    snippets,
    s(
      callout,
      fmt(
        '#' .. callout .. [[

> {}
> {}
        ]],
        {
          i(1, ""),
          i(2, ""),
        }
      )
    )
  )
end

return snippets, {}
