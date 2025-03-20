local astrocore = require("astrocore")

astrocore.set_mappings({
  n = {
    ['<A-Space>'] = { '<Plug>(neorg.qol.todo-items.todo.task-cycle)', desc = 'Increment task state' },
  },

  i = {
    ['<CR>'] = { '<Plug>(neorg.itero.next-iteration)', desc = 'Drop into next iteration' },
  },
})
