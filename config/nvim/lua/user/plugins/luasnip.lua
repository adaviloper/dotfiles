return {
  "L3MON4D3/LuaSnip",
  enabled = true,
  config = function(plugin, opts)
    local ls = require("luasnip")
    require "plugins.configs.luasnip" (plugin, opts) -- include the default astronvim config that calls the setup call
    ls.setup()
    -- require("luasnip.loaders.from_lua").load({ paths = { "./lua/user/snippets" } }) -- load snippets paths
    return opts
  end,
}
