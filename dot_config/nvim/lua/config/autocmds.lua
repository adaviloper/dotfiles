-- nvim-treesitter's xml grammar has a native crash bug parsing plist-shaped XML
-- (nested dict/array + self-closing tags). Every consumer (AstroCore's auto_install
-- + highlight FileType autocmd, the default treesitter foldexpr, indentexpr, picker
-- previews, ...) resolves filetype -> language via get_lang() before doing anything
-- else, so refusing it there means xml never triggers install/parse attempts at all.
local ts_get_lang = vim.treesitter.language.get_lang
---@diagnostic disable-next-line: duplicate-set-field
vim.treesitter.language.get_lang = function(filetype)
  if filetype == 'xml' then return nil end
  return ts_get_lang(filetype)
end

local function smart_close()
  if #vim.api.nvim_tabpage_list_wins(0) > 1 then
    vim.cmd('quit')
  else
    vim.cmd('bdelete')
  end
end

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
    vim.keymap.set('n', 'q', smart_close, { buffer = args.buf })
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('adaviloper/fugitive_blob_q', { clear = true }),
  desc = 'Close fugitive blobs with <q> without quitting neovim',
  pattern = 'fugitive://*',
  callback = function(args)
    vim.keymap.set('n', 'q', smart_close, { buffer = args.buf })
  end,
})

local win_group = vim.api.nvim_create_augroup('adaviloper/split_right', { clear = true })

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = win_group,
  pattern = { 'help', 'man' },
  command = 'wincmd L',
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('adaviloper/fugitiveblame_winbar', { clear = true }),
  pattern = 'fugitiveblame',
  callback = function()
    vim.wo.winbar = ' '
  end,
})

local misc_group = vim.api.nvim_create_augroup('adaviloper/miscellaneous', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = misc_group,
  command = 'checktime',
})
