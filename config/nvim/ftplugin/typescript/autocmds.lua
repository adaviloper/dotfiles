local ts_group = vim.api.nvim_create_augroup('TypeScript Autotemplates', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*/2024/*.ts',
  group = ts_group,
  callback = function (params)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    if #lines == 1 and lines[1] == '' then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, {
        "import { input } from './data/" .. vim.fn.expand('%:t:r') .. ".data.ts';",
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
    end
  end,
})
