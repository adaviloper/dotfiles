local snippet_utils = require("helpers.snippet_utils")

return
  {
    s(
      'person',
      fmt(
        [=[{{:$/people/{}.norg:}}[{}]]=],
        {
          f(snippet_utils.slug_case_var, { 1 }),
          i(1),
        }
      )
    ),
    s(
      'service',
      fmt(
        [=[{{:$/services/{}.norg:}}[{}]]=],
        {
          f(snippet_utils.slug_case_var, { 1 }),
          i(1),
        }
      )
    ),
  },
  {}
