return {
  "L3MON4D3/LuaSnip",
  event = 'User AstroFile',
  config = function(plugin, opts)
    -- require("plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
    local ls = require("luasnip")
    local types = require('luasnip.util.types')
    require("luasnip.loaders.from_lua").load({
      paths = { "~/.config/nvim/snippets/" }
    }) -- load snippets paths
    -- local types = require("luasnip.util.types")
    ls.setup({
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,

      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '<-', 'Error' } },
          }
        }
      }
    })

  end,
}
