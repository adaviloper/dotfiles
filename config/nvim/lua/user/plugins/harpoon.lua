return {
  'ThePrimeagen/harpoon2',
  enabled = false,
  lazy = true,
  config = function ()
    require('harpoon').setup({
      global_settings = {
        mark_branch = true,
      }
    })
  end
}
