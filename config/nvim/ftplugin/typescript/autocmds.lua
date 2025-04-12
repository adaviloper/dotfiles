local file_utils = require "helpers.file_utils"
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

vim.api.nvim_create_autocmd({ 'BufNew', 'BufNewFile' }, {
  pattern = '*/store/*.ts',
  group = ts_group,
  callback = function (args)
    if args.file:match(".*/store/%a+%.ts") then
      vim.notify(vim.inspect(args.file))
      vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, {
        "import { defineStore } from 'pinia'",
        "",
        "type State = {",
        "",
        "};",
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

      vim.cmd([[w]])
      vim.cmd([[e]])
    end
  end,
})


vim.api.nvim_create_autocmd({ 'BufNew', 'BufNewFile' }, {
  pattern = '*/router/*.ts',
  group = ts_group,
  callback = function (args)
    if args.file:match(".*/router/%a+%.ts") then
      vim.api.nvim_buf_set_lines(args.buf or 0, 0, -1, false, {
        "import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router'",
        "import HelloWorld from '@/components/HelloWorld.vue';",
        "",
        "const routes: RouteRecordRaw[] = [",
        "  {",
        "    path: '/',",
        "    component: HelloWorld",
        "  },",
        "];",
        "",
        "const router = createRouter({",
        "  history: createWebHistory(),",
        "  routes,",
        "});",
        "",
        "export {",
        "  router,",
        "}",
        "",
      })

      vim.cmd([[w]])
      vim.cmd([[e]])
    end
  end,
})

