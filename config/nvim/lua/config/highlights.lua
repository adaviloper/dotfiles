-- Highlight the @foo.bar capture group with the "Identifier" highlight group
vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = "#89dceb" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
  undercurl = true,
  sp = "#f38ba8"
})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
  undercurl = true,
  sp = "#f9e2af"
})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
  undercurl = true,
  sp = "#89dceb"
})
vim.api.nvim_set_hl(0, "SpellBad", {
  undercurl = true,
  sp = "#a6e3a1"
})
