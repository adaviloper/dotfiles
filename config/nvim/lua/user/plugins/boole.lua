return {
  'nat-418/boole.nvim',
  config = function()
    local i = 'true'
    require('boole').setup({
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>'
      },
      -- User defined loops
      additions = {
        {'production', 'development', 'local', 'testing'},
        {'protected', 'public', 'private'},
        {'let', 'const'},
        {'==', '==='},
        {'!=', '!=='},
        {'get', 'set'},
      },
      allow_caps_additions = {
        {'enable', 'disable'}
      }
    })
  end,
  event = { "BufReadPost" }, -- lazy load after reading a buffer
}
