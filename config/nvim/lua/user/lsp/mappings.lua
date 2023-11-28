return {
  n = {
    -- this mapping will only be set in buffers with an LSP attached
    K = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
    ["gd"] = {
      function ()
        local symbolize = require('php-symbolize')
        if symbolize.validate_touple() then
          symbolize.go_to_definition()
        else
          require("telescope.builtin").lsp_definitions()
        end
      end,
      desc = "Go to definition",
    },
  },
}
