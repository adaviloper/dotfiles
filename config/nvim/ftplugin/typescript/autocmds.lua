local ts_group = vim.api.nvim_create_augroup('TypeScript Autotemplates', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*/2024/*.ts',
  group = ts_group,
  callback = function (params)
    local file_name = vim.fn.expand('%:t:r')
    -- vim.cmd('!touch ./data/' .. file_name .. '.data.ts')
    require('config.commands.tpl').insert_template({
      "import { input } from './data/" .. file_name .. ".data.ts';",
      "",
      "const env = 'prod';",
      "const data = input[env];",
      "",
      "const p1 = () => {",
      "  ",
      "}",
      "",
      "const p2 = () => {",
      "}",
      "",
      "console.log('p1', p1())",
      "console.log('p2', p2())",
    })
    vim.api.nvim_win_set_cursor(0, { 7, 1 })
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*/store/*.ts',
  group = ts_group,
  callback = function (params)
    require('config.commands.tpl').insert_template({
      "import { defineStore } from 'pinia'",
      "",
      "interface State {",
      "",
      "}",
      "",
      "export const useMainStore = defineStore('main', {",
      "  state: (): State => ({",
      "  }),",
      "",
      "  actions: {",
      "  },",
      "",
      "  getters: {",
      "  },",
      "})",
    })
    vim.api.nvim_win_set_cursor(0, { 4, 1 })
  end,
})
