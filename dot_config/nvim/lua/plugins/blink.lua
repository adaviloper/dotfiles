return {
  "Saghen/blink.cmp",
  opts = {
    -- preset = 'none',
    keymap = {
      ["<Up>"] = {},
      ["<Down>"] = {},
      ["<C-n>"] = { "select_next", "show" },
      ["<C-p>"] = { "select_prev", "show" },
      ["<C-j>"] = { 'snippet_forward', 'fallback' },
      ["<C-k>"] = { 'snippet_backward', 'fallback' },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-y>"] = { "accept", "fallback" },
      ["<C-i>"] = { "show_signature", "hide_signature", "fallback" },
      ["<Tab>"] = {},
      ["<S-Tab>"] = {},
    },
  },
}

