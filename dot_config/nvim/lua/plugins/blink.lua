return {
  "Saghen/blink.cmp",
  opts = {
    -- preset = 'none',
    keymap = {
      ["<Up>"] = {},
      ["<Down>"] = {},
      ["<C-n>"] = { "select_next", "show" },
      ["<C-p>"] = { "select_prev", "show" },
      -- disable C-j/C-k so they don't override snippet navigation
      ["<C-j>"] = {},
      ["<C-k>"] = {},
      ["<C-J>"] = {},
      ["<C-K>"] = {},
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-y>"] = { "accept", "fallback" },
      ["<C-i>"] = { "show_signature", "hide_signature", "fallback" },
      ["<Tab>"] = {},
      ["<S-Tab>"] = {},
    },

    sources = {
      providers = {
        snippets = { score_offset = 10 },
        path = { score_offset = 3 },
        lsp = { score_offset = 0 },
        buffer = { score_offset = -3 },
      },
    },
  },
}

