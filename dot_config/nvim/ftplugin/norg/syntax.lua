local mocha = require("catppuccin.palettes").get_palette "mocha"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  callback = function()
    vim.o.conceallevel = 1 -- Enable concealment
    vim.o.concealcursor = "nc" -- Conceal even under the cursor

    local callouts = {
      {
        icon = "@BugCarryoverIcon",
        header = "@BugCarryoverHeader",
        color = mocha.maroon,
      },

      {
        icon = "@InfoCarryoverIcon",
        header = "@InfoCarryoverHeader",
        color = mocha.teal,
      },

      {
        icon = "@NoteCarryoverIcon",
        header = "@NoteCarryoverHeader",
        color = mocha.yellow,
      },

      {
        icon = "@QuestionCarryoverIcon",
        header = "@QuestionCarryoverHeader",
        color = mocha.sky,
      },

      {
        icon = "@QuoteCarryoverIcon",
        header = "@QuoteCarryoverHeader",
        color = mocha.mauve,
      },

      {
        icon = "@SuccessCarryoverIcon",
        header = "@SuccessCarryoverHeader",
        color = mocha.green,
      },

      {
        icon = "@WarningCarryoverIcon",
        header = "@WarningCarryoverHeader",
        color = mocha.peach,
      },
    }

    for _, callout in ipairs(callouts) do
      vim.api.nvim_set_hl(0, callout.icon, { fg = callout.color, bg = "NONE" })
      vim.api.nvim_set_hl(0, callout.header, { bg = callout.color, fg = mocha.crust })
    end
  end,
})
