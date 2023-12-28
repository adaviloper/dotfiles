return {
  "L3MON4D3/LuaSnip",
  enabled = true,
  config = function(plugin, opts)
    -- local ls = require("luasnip")
    -- local types = require("luasnip.util.types")
    require "plugins.configs.luasnip" (plugin, opts) -- include the default astronvim config that calls the setup call
    -- ls.setup({
    --   history = true,
    --
    --   updateevents = 'TextChanged,TextChangedI',
    --
    --   enable_autosnippets = true,
    --
    --   ext_opts = {
    --     [types.choiceNode] = {
    --       active = {
    --         virt_text = { { '<-', 'Error' } },
    --       }
    --     }
    --   }
    -- })

    -- require("luasnip.loaders.from_lua").load({ paths = { "./lua/user/snippets" } }) -- load snippets paths
  end,
}
