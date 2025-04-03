local astrocore = require("astrocore")
local neorg_templates = require("helpers.neorg_templates")

astrocore.set_mappings({
  n = {
    ['<A-Space>'] = { '<Plug>(neorg.qol.todo-items.todo.task-cycle)', desc = 'Increment task state' },
    ['<Leader>n'] = { name = "󱓩 Notes" },
    ['<Leader>nd'] = { function () neorg_templates.createDailyEntry() end, desc = 'Create a daily note' },
    ['<Leader>nw'] = { function () neorg_templates.createWeeklyEntry() end, desc = 'Create a weekly note' },
    ['<Leader>np'] = { function () neorg_templates.createPerson() end, desc = 'Create a new person note' },

    ['<LocalLeader>t'] = {
      '<Cmd>Neorg toc<CR>',
      desc = 'Open Table of Contents'
    },
  },

  i = {
    ['<A-CR>'] = { '<Plug>(neorg.itero.next-iteration)', desc = 'Drop into next iteration' },
  },
})
