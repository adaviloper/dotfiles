return {
  'nat-418/boole.nvim',
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
        {'up', 'right', 'down', 'left'},
        {'top', 'bottom'},
        {'==', '==='},
        {'!=', '!=='},
      },
      allow_caps_additions = {
        {'enable', 'disable'}
      }
    })
  end,
  event = { "BufReadPost" }, -- lazy load after reading a buffer
}
