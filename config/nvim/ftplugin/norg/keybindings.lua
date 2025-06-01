local astrocore = require("astrocore")
local neorg_templates = require("helpers.neorg_templates")

astrocore.set_mappings({
  n = {
    ['<LocalLeader>cn'] = { '<Plug>(neorg.qol.todo-items.todo.task-cycle)', desc = 'Increment task state' },
    ['<LocalLeader>n'] = { name = "󱓩 Notes" },
    ['<LocalLeader>nc'] = { function () neorg_templates.createCompany() end, desc = 'Create a new company note' },
    ['<LocalLeader>nd'] = { function () neorg_templates.createDailyEntry() end, desc = 'Create a daily note' },
    ['<LocalLeader>nm'] = { function () neorg_templates.createMeetingNote() end, desc = 'Create a meeting note' },
    ['<LocalLeader>no'] = { function () neorg_templates.createOneOnOneNote() end, desc = 'Create a One-on-One note' },
    ['<LocalLeader>np'] = { function () neorg_templates.createPerson() end, desc = 'Create a new person note' },
    ['<LocalLeader>nt'] = { function () neorg_templates.createTicket() end, desc = 'Create a ticket note' },
    ['<LocalLeader>nw'] = { function () neorg_templates.createWeeklyEntry() end, desc = 'Create a weekly note' },

    ['<LocalLeader><LocalLeader>t'] = {
      '<Cmd>e to-do.norg<CR>',
      desc = 'Open To Do list'
    },

    ['<LocalLeader>t'] = {
      '<Cmd>Neorg toc<CR>',
      desc = 'Open Table of Contents'
    },
  },

  i = {
    ['<A-CR>'] = { '<Plug>(neorg.itero.next-iteration)', desc = 'Drop into next iteration' },
  },
})
