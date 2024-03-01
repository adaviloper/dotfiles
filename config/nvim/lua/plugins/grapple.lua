return {
  'cbochs/grapple.nvim',
  config = function()
    require('grapple').setup({
      scope = require('grapple.scope').suffix(
        require('grapple').resolvers.directory,
        require('grapple').resolvers.git_branch_suffix,
        {
          persist = true,
        }
      ),
      popup_options = {
        width = 150,
      },
    })
  end,
}
