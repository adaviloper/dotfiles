return {
  'cbochs/grapple.nvim',
  config = function ()
    require('grapple').setup({
      scope = require('grapple').resolvers.git_branch
    })
  end,
}
