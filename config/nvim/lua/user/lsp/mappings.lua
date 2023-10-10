return {
  n = {
    -- this mapping will only be set in buffers with an LSP attached
    K = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
  },
}
