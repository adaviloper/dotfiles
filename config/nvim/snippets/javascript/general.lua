local snippet_utils = require("helpers.snippet_utils")

return
  {
    s(
      'req',
      fmt([[const {} = require('{}')]], {
        f(snippet_utils.camelize_var, { 1 }),
        i(1),
      })
    ),
  },
  {
  }
