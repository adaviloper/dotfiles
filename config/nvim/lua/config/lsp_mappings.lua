local function select_template(template)
  return function ()
    vim.lsp.buf.code_action({
      filter = function (ca)
        if ca.command ~= nil and ca.command.title ~= nil then
          if ca.command.title:find(template) then
            return true
          end
        end
        return false
      end,
      apply = true
    })
  end
end

local function lksjdfsf()
  vim.lsp.buf.code_action({
    filter = function (ca)
      if ca.command ~= nil and ca.command.title ~= nil then
        local file = vim.fn.expand("%:p:.")
        for _, type in ipairs({ 'Feature', 'Unit', 'Job', 'Listener', 'Model' }) do
          if file:find(type) then
            return ca.command.title:find(type) ~= nil
          end
        end
        if ca.command.title:find('default') then
          return true
        end
      end
      return false
    end,
    apply = true
  })
end

return {
  n = {
    gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
    gd = {
      function ()
        -- require('php-dev-tools.go_to').go_to_definition()
        require('telescope.builtin').lsp_definitions()
        vim.cmd('norm zt')
      end,
      desc = "Go to definition",
    },
    -- condition for only server with declaration capabilities
    gD = {
      function()
        vim.lsp.buf.declaration()
      end,
      desc = "Declaration of current symbol",
      cond = "textDocument/declaration",
    },
    ["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "Go to references" },
    -- this mapping will only be set in buffers with an LSP attached
    K = {
      function()
        vim.lsp.buf.hover()
      end,
      desc = "Hover symbol details",
    },
    ["<Leader>lt"] = { name = "PhpActor Templates" },
    ["<Leader>lta"] = {
      lksjdfsf,
      desc = 'Auto-generate template for the current file',
    },
    ["<Leader>ltt"] = {
      select_template('trait'),
      desc = 'Auto-generate template for the current file',
    },
    ["<Leader>lo"] = {
      function ()
        vim.lsp.buf.code_action({
          filter = function (ca)
            if ca.command ~= nil then
              return ca.command.title == 'Remove unused imports'
            end
            return false
          end,
          apply = true
        })
      end,
      desc = 'Optimize imports',
    },
  },
}
