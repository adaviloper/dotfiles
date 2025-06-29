return {
  "L3MON4D3/LuaSnip",
  event = "User AstroFile",
  config = function(plugin, opts)
    require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call

    local ls = require "luasnip"
    local types = require "luasnip.util.types"
    -- require("luasnip.loaders.from_vscode")

    require("luasnip.loaders.from_lua").load {
      paths = { "~/.config/nvim/snippets/" },
    } -- load snippets paths
    ls.setup({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,

      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "<- Current Choice", "Error" } },
          },
        },
      },
		-- Also load both lua and json when a markdown-file is opened,
		-- javascript for html.
		-- Other filetypes just load themselves.
    --   load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
			 --  markdown = {"lua", "json"},
			 --  html = {"javascript"},
			 --  vue = {"javascript", "sass", "scss", "typescript"},
		  -- })
      load_ft_func = require("luasnip.extras.filetype_functions").from_cursor_pos
    })
  end,
}
