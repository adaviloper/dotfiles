local astrocore = require("astrocore")

astrocore.set_mappings({
  n = {
    ['<F4><F4>'] = { function() require('kulala').replay() end, desc = "Replay the last request" },
    ['<F4>f'] = { function() require('kulala').run_all() end, desc = "Send all request" },
    ['<F4>n'] = { function() require('kulala').run() end, desc = "Send request" },
  },
})

