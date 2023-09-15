return {
  'ThePrimeagen/harpoon',
  enabled = true,
  lazy = true,
  config = function ()
    require('harpoon').setup({
      global_settings = {
        mark_branch = true,
      }
    })
  end
}
