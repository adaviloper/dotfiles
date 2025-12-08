return {
  'Ipomoea/increment.nvim',
  enabled = true,
  config = function()
    require('increment').setup({
      -- mappings = {
      --   increment = '<C-a>',
      --   decrement = '<C-x>'
      -- },
      -- User defined loops
      groups = {
        {'get', 'set'},
        {'up', 'down'},
        {'true', 'false'},
        {'==', '==='},
        {'!=', '!=='},
      },
      lang_groups = {
        php = {
          {'dd', 'dump'},
          {'protected', 'public', 'private'},
        },
        javascript = {
          {'let', 'const', 'var'},
          {'skip', 'only'},
        },
        typescript = {
          {'const', 'let', 'var'},
          {'skip', 'only'},
        },
        sh = {
          {'production', 'development', 'local', 'testing'},
        }
      },
    })
  end,
  event = { "BufReadPost" }, -- lazy load after reading a buffer
}
