return {
  'nat-418/boole.nvim',
  enabled = true,
  config = function()
    require('boole').setup({
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>'
      },
      -- User defined loops
      additions = {
        {'dd', 'dump'},
        {'get', 'set'},
        {'let', 'const', 'var'},
        {'production', 'development', 'local', 'testing'},
        {'protected', 'public', 'private'},
        {'skip', 'only'},
        {'up', 'down'},
        {'==', '==='},
        {'!=', '!=='},
      },
    })
  end,
  event = { "BufReadPost" }, -- lazy load after reading a buffer
}
