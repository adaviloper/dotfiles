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
    },
    config = function ()
      -- PHP
      require('lspconfig').intelephense.setup({})

      -- Vue, JavaScript, Typescript
      require('lspconfig').volar.setup({
        -- Enable "Take Over Mode" where avolar will provide all JS/TS LSP services
        -- This drastically improves the responsiveness of diagnostic updates on change
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
      })

      -- TailwindCSS
      require('lspconfig').tailwindcss.setup({})
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
