local str_utils = require("helpers.str_utils")
local require_var = function(args, _)
  local text = args[1][1] or ""
  local camel_str = str_utils.camel(text)
  return sn(nil, {
    c(1, {
      t(camel_str)
    })
  })
end

return
  {
    s(
      'req',
      fmt([[const {} = require('{}')]], {
        d(2, require_var, { 1 }),
        i(1),
      })
    ),
  },
  {
  }
