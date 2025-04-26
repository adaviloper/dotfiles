local astrocore = require("astrocore")

astrocore.set_mappings({
  n = {
    ['<LocalLeader>ts'] = { "<cmd>ToggleSyntax<CR>", desc = "Toggle arrow function syntax" },
  },
  v = {
    ['<LocalLeader>xv'] = { '<cmd>ExtractToVariable<cr>', desc = "Extract to a variable" },
  },
})
