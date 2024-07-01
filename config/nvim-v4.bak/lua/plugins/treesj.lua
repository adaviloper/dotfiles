return {
  'Wansmer/treesj',
  -- keys = { '<space>m', '<space>j', '<space>s' },
  event = 'User AstroFile',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    local lang_utils = require('treesj.langs.utils')
    require('treesj').setup({
      use_default_keymaps = false,
      dot_repeat = true,
      langs = {
        javascript = {
          object = lang_utils.set_preset_for_dict({
            both = {
              recursive = true,
            },
          }),
          array = lang_utils.set_preset_for_list(),
          formal_parameters = lang_utils.set_preset_for_args(),
          arguments = lang_utils.set_preset_for_args(),
        },
      },
      max_join_length = 10000,
      notify = false,
    })
  end,
}
