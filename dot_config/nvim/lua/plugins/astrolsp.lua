-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
	"AstroNvim/astrolsp",
	---@type AstroLSPOpts
	opts = {
		-- Configuration table of features provided by AstroLSP
		features = {
			codelens = true, -- enable/disable codelens refresh on start
			inlay_hints = false, -- enable/disable inlay hints on start
			semantic_tokens = true, -- enable/disable semantic token highlighting
		},
		-- customize lsp formatting options
		formatting = {
			-- control auto formatting on save
			format_on_save = {
				enabled = false, -- enable or disable format on save globally
				allow_filetypes = { -- enable format on save for specified filetypes only
					-- "go",
				},
				ignore_filetypes = { -- disable format on save for specified filetypes
					-- "python",
				},
			},
			disabled = { -- disable formatting capabilities for the listed language servers
				-- disable lua_ls formatting capability if you want to use StyLua to format your lua code
				-- "lua_ls",
			},
			timeout_ms = 1000, -- default format timeout
			-- filter = function(client) -- fully override the default formatting function
			--   return true
			-- end
		},
		-- enable servers that you already have installed without mason
		servers = {
			-- "pyright"
		},
		-- customize language server configuration passed to `vim.lsp.config`
		-- client specific configuration can also go in `lsp/` in your configuration root (see `:h lsp-config`)
		config = {
			-- ["*"] = { capabilities = {} }, -- modify default LSP client settings such as capabilities
			gopls = {
				settings = {
					gopls = {
						analyses = {
							ST1003 = true,
							fieldalignment = false,
							fillreturns = true,
							nilness = true,
							nonewvars = true,
							shadow = true,
							undeclaredname = true,
							unreachable = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						codelenses = {
							gc_details = true, -- Show a code lens toggling the display of gc's choices.
							generate = true, -- show the `go generate` lens.
							regenerate_cgo = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						buildFlags = { "-tags", "integration" },
						completeUnimported = true,
						diagnosticsDelay = "500ms",
						matcher = "Fuzzy",
						semanticTokens = true,
						staticcheck = true,
						symbolMatcher = "fuzzy",
						usePlaceholders = true,
					},
				},
			},
			phpactor = {
				init_options = {
					["language_server_phpstan.enabled"] = false,
					["language_server_php_cs_fixer.enabled"] = false,
					["code_transform.template_paths"] = {
						"~/.config/phpactor/templates/",
					},
				},
			},
			tailwindcss = {
				filetypes = { "html", "css", "scss", "postcss", "tsx", "jsx", "js", "ts", "vue" },
			},
			eslint = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascriptreact.jsx",
					"typescript",
					"typescriptreact",
					"typescriptreact.tsx",
				},
				root_dir = function(...)
					return require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git")(...)
				end,
			},
			-- tsgo = {
			--   cmd = { "tsgo", "--lsp", "--stdio" },
			--   filetypes = {
			--     "javascript",
			--     "javascriptreact",
			--     "javascriptreact.jsx",
			--     "typescript",
			--     "typescriptreact",
			--     "typescriptreact.tsx",
			--   },
			--   root_dir = function (...)
			--     return require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git")(...)
			--   end,
			-- },
		},
		-- customize how language servers are attached
		handlers = {
			-- a function with the key `*` modifies the default handler, functions takes the server name as the parameter
			-- ["*"] = function(server) vim.lsp.enable(server) end

			-- the key is the server that is being setup with `vim.lsp.config`
			-- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
			tsgo = false,
		},
		-- Configure buffer local auto commands to add when attaching a language server
		autocmds = {
			-- first key is the `augroup` to add the auto commands to (:h augroup)
			lsp_codelens_refresh = {
				-- Optional condition to create/delete auto command group
				-- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
				-- condition will be resolved for each client on each execution and if it ever fails for all clients,
				-- the auto commands will be deleted for that buffer
				cond = "textDocument/codeLens",
				-- cond = function(client, bufnr) return client.name == "lua_ls" end,
				-- list of auto commands to set
				{
					-- events to trigger
					event = { "InsertLeave", "BufEnter" },
					-- the rest of the autocmd options (:h nvim_create_autocmd)
					desc = "Refresh codelens (buffer)",
					callback = function(args)
						if require("astrolsp").config.features.codelens then
							if vim.lsp.codelens.enable then
								vim.lsp.codelens.enable(true, { bufnr = args.buf })
							else
								vim.lsp.codelens.refresh({ bufnr = args.buf })
							end
						end
					end,
				},
			},
		},
		-- mappings to be set up on attaching of a language server
		mappings = require("config.lsp_mappings"),
		-- A custom `on_attach` function to be run after the default `on_attach` function
		-- takes two parameters `client` and `bufnr`  (`:h lsp-attach`)
		on_attach = function(client, bufnr)
			-- this would disable semanticTokensProvider for all clients
			-- client.server_capabilities.semanticTokensProvider = nil
		end,
	},
}
