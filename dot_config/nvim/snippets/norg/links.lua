local snippet_utils = require("helpers.snippet_utils")

return {
  s(
    {
      trig = "person",
      desc = "Link a person",
    },
    fmta([=[{:$/people/<file_name>.norg:}[<name>]]=], {
      file_name = f(snippet_utils.slug_case_var, { 1 }),
      name = i(1),
    })
  ),
  s(
    {
      trig = "service",
      desc = "Link a service",
    },
    fmt([=[{{:$/services/{}.norg:}}[{}]]=], {
      f(snippet_utils.slug_case_var, { 1 }),
      i(1),
    })
  ),
  s(
    {
      trig = "team",
      desc = "Link a team",
    },
    fmt([=[{{:$/services/{}.norg:}}[{}]]=], {
      f(snippet_utils.slug_case_var, { 1 }),
      i(1),
    })
  ),
}, {}
