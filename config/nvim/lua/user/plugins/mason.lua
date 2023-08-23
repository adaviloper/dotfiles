-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    dependencies = {
      'hrsh7th/cmp-nvim-lsp-signature-help'
    },
    opts = {
      -- ensure_installed = { "lua_ls" },
      ensure_installed = { "all" },
      automatic_installation = true,
    },
    config = function ()
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- PHP
      require('lspconfig').intelephense.setup({
        commands = {
          IntelephenseIndex = {
            function ()
              vim.lsp.buf.execute_comand({ command = 'intelephense.index.workspace' })
            end
          },
        },
        on_attach = function (client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        capabilities = capabilities
      })
      require('lspconfig').phpactor.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          client.server_capabilities.completionProvider = false
          client.server_capabilities.hoverProvider = false
          client.server_capabilities.implementationProvider = false
          client.server_capabilities.referencesProvider = false
          client.server_capabilities.renameProvider = false
          client.server_capabilities.selectionRangeProvider = false
          client.server_capabilities.signatureHelpProvider = false
          client.server_capabilities.typeDefinitionProvider = false
          client.server_capabilities.workspaceSymbolProvider = false
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.documentHighlightProvider = false
          client.server_capabilities.documentSymbolProvider = false
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        init_options = {
          ["language_server_phpstan.enabled"] = false,
          ["language_server_psalm.enabled"] = false,
        },
        handlers = {
          ['textDocument/publishDiagnostics'] = function() end
        }
      })

      -- Vue, JavaScript, Typescript
      require('lspconfig').volar.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          -- if client.server_capabilities.inlayHintProvider then
          --   vim.lsp.buf.inlay_hint(bufnr, true)
          -- end
        end,
        capabilities = capabilities,
        -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
        -- This drastically improves the responsiveness of diagnostic updates on change
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      })

      -- TailwindCSS
      require('lspconfig').tailwindcss.setup({ capabilities = capabilities })

      -- JSON
      require('lspconfig').jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          },
        },
      })
      -- Lua
      require('lspconfig').lua_ls.setup({ capabilities = capabilities })
    end
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      -- ensure_installed = { "prettier", "stylua" },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      -- ensure_installed = { "python" },
      handlers = {
        php = function()
          local dap = require "dap"
          dap.adapters.php = {
            type = "executable",
            command = os.getenv "HOME" .. "/.local/share/nvim_astro/mason/bin/php-debug-adapter",
          }

          dap.configurations.php = {
            {
              type = "php",
              request = "launch",
              port = 9003,
              name = "Listen for Xdebug",
            },
          }
        end,
      },
    },
  },
}
