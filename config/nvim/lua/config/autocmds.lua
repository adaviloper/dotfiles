vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('adaviloper/close_with_q', { clear = true }),
  desc = 'Close with <q>',
  pattern = {
    'fugitiveblame',
    'git',
    'help',
    'man',
    'qf',
    'query',
    'scratch',
  },
  callback = function(args)
    vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = args.buf })
  end,
})

local win_group = vim.api.nvim_create_augroup('adaviloper/split_right', { clear = true })

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = win_group,
  pattern = { 'help', 'man' },
  command = 'wincmd L',
})

local misc_group = vim.api.nvim_create_augroup('adaviloper/miscellaneous', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  group = misc_group,
  pattern = {
    '*.js',
    '*.lua',
    '*.php',
    '*.ts',
    '*.vue',
  },
  command = 'checktime',
})
