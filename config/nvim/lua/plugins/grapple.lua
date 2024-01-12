return {
  'cbochs/grapple.nvim',
  config = function()
    require('grapple').setup({
      scope = require('grapple').resolvers.git_branch,
      popup_options = {
        width = 150,
      },
    })
  end,
}
