-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function (_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        {
          'bashls',
          'cssls',
          'jsonls',
          'lua_ls',
          'marksman',
          'phpactor',
          'tailwindcss',
          'tsserver',
          'volar',
        }
      )
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      lspconfig.bashls.setup({
        capabilities = capabilities,
        filetypes = { 'sh', 'ttyfast', 'zsh' }
      })
      -- lspconfig.intelephense.setup({
      --   capabilities = capabilities,
      -- })
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            -- schemas = require('schemastore').json.schemas(),
          }
        }
      })
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.pest_ls.setup({ capabilities = capabilities })
      lspconfig.phpactor.setup({
        capabilities = capabilities,
        -- init_options = {
          -- ['language_server_phpstan.enabled'] = true,
          -- ['language_server_psalm.enabled'] = false,
        -- },
        -- handlers = {
          -- ['textDocument/publishDiagnostics'] = function() end,
        -- },
      })
      lspconfig.tailwindcss.setup({ capabilities = capabilities })

      return opts
    end
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        {
          "stylua",
        }
      )
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    enabled = false,
    dependencies = {
      'nvim-neotest/nvim-nio',
    },
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        {
          -- "python",
          "js-debug-adapter",
          "php-debug-adapter",
        }
      )
    end,
  },
}
