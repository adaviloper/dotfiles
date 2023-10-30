-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
    end,
    config = function (_, opts)
      opts.ensure_installed = 'all'
      opts.automatic_installation = true
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      require('lspconfig').bashls.setup({ 
        capabilities = capabilities,
        filetypes = { 'sh', 'zsh' }
      })
      require('lspconfig').intelephense.setup({ 
        capabilities = capabilities,
        pattern = 'php',
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          }
        }
      })
      require('lspconfig').jsonls.setup({ 
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          }
        }
      })
      require('lspconfig').lua_ls.setup({ capabilities = capabilities })
      require('lspconfig').tailwindcss.setup({ capabilities = capabilities })
      require('lspconfig').volar.setup({
        capabilities = capabilities,
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      })
      -- opts.handlers = {
      --   -- The first entry (without a key) will be the default handler
      --   -- and will be called for each installed server that doesn't have
      --   -- a dedicated handler.
      --   function (server_name) -- default handler (optional)
      --       require("lspconfig")[server_name].setup {}
      --   end,
      --   -- Next, you can provide targeted overrides for specific servers.
      --   ["intelephense"] = function ()
      --     lspconfig.intelephense.setup()
      --   end,
      --   ["bashls"] = function ()
      --     local lspconfig = require("lspconfig")
      --     lspconfig.bashls.setup({
      --       settings = {
      --         bashIde = {
      --           -- Glob pattern for finding and parsing shell script files in the workspace.
      --           -- Used by the background analysis features across files.
      --
      --           -- Prevent recursive scanning which will cause issues when opening a file
      --           -- directly in the home directory (e.g. ~/foo.sh).
      --           --
      --           -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
      --           globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.zsh|.inc|.bash|.command)',
      --         },
      --       },
      --       filetypes = {'sh', 'zsh'}
      --     })
      --   end,
      --
      -- }
      return opts
    end
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- "prettier",
        -- "stylua",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- "python",
        "js-debug-adapter",
        "php-debug-adapter",
      })
    end,
  },
}
