local snippet_utils = require("helpers.snippet_utils")

return
  {
    s(
      'person',
      fmt(
        [=[{{:$/people/{}.norg:}}[{}]]=],
        {
          i(1),
          f(snippet_utils.title_case_var, { 1 })
        }
      )
    ),
    s(
      'service',
      fmt(
        [=[{{:$/services/{}.norg:}}[{}]]=],
        {
          i(1),
          f(snippet_utils.title_case_var, { 1 })
        }
      )
    ),
  },
  {}
