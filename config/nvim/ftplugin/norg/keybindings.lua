local astrocore = require("astrocore")
local neorg_templates = require("helpers.neorg_templates")

astrocore.set_mappings({
  n = {
    ['<A-Space>'] = { '<Plug>(neorg.qol.todo-items.todo.task-cycle)', desc = 'Increment task state' },
    ['<Leader>n'] = { name = "󱓩 Notes" },
    ['<LocalLeader>c'] = { function () neorg_templates.createCompany() end, desc = 'Create a new company note' },
    ['<LocalLeader>d'] = { function () neorg_templates.createDailyEntry() end, desc = 'Create a daily note' },
    ['<LocalLeader>m'] = { function () neorg_templates.createMeetingNote() end, desc = 'Create a meeting note' },
    ['<LocalLeader>p'] = { function () neorg_templates.createPerson() end, desc = 'Create a new person note' },
    ['<LocalLeader>w'] = { function () neorg_templates.createWeeklyEntry() end, desc = 'Create a weekly note' },

    ['<LocalLeader>t'] = {
      '<Cmd>Neorg toc<CR>',
      desc = 'Open Table of Contents'
    },
  },

  i = {
    ['<A-CR>'] = { '<Plug>(neorg.itero.next-iteration)', desc = 'Drop into next iteration' },
  },
})
