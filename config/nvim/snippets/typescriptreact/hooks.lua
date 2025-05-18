local snippet_utils = require("helpers.snippet_utils")
return
  {
    s(
      'state',
      fmt([[const [{}, set{}] = useState{}({});]], {
        i(1),
        f(snippet_utils.pascal_case_var, { 1 }),
        i(0),
        i(2),
      })
    )
  },
  {}
