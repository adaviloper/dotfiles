local astrocore = require("astrocore")

astrocore.set_mappings({
  n = {
    ['<LocalLeader>ts'] = { "<cmd>ToggleSyntax<CR>", desc = "Toggle arrow function syntax" },
    ['<F4><F4>'] = { function ()
      local file = vim.fn.expand("%:p:.")
      vim.cmd('TermExec cmd="nrt ' .. file .. '"')
    end, desc = "Toggle arrow function syntax" },
  },
  v = {
    ['<LocalLeader>xv'] = { '<cmd>Extract variable<cr>', desc = "Extract to a variable" },
  },
})
