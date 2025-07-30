return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/nvim-cmp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},

	config = function()
		-- Setup nvim-cmp
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		-- Enhanced Mason setup with better UI and automatic installation
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				},
				border = "rounded",
				width = 0.8,
				height = 0.8,
			},
			-- Automatically install packages when they're missing
			automatic_installation = true,
		})

		-- Comprehensive LSP server list with automatic installation
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",           -- Lua
				"ts_ls",            -- TypeScript/JavaScript
				"eslint",           -- ESLint
				"gopls",            -- Go
				"elixirls",         -- Elixir
				"rust_analyzer",    -- Rust
				"pyright",          -- Python
				"clangd",           -- C/C++
				"jsonls",           -- JSON
				"cssls",            -- CSS
				"html",             -- HTML
				"yamlls",           -- YAML
				"marksman",         -- Markdown
				"dockerls",         -- Docker
			},
			automatic_installation = true,
			-- Auto-configure servers after installation
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
			},
		})

		-- Enhanced TypeScript setup with better configuration
		require("lspconfig").ts_ls.setup({
			capabilities = capabilities,
			cmd = { "typescript-language-server", "--stdio" },
			root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
			single_file_support = true,
			init_options = {
				hostInfo = "neovim",
				preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		})

		-- Enhanced ESLint setup
		require("lspconfig").eslint.setup({
			capabilities = capabilities,
			root_dir = require("lspconfig").util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json"),
			settings = {
				workingDirectory = { mode = "auto" },
				validate = "on",
				packageManager = "npm",
			},
		})

		-- Enhanced Go setup
		require("lspconfig").gopls.setup({
			capabilities = capabilities,
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
						shadow = true,
					},
					staticcheck = true,
					usePlaceholders = true,
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
				},
			},
		})

		-- Enhanced Lua setup
		require("lspconfig").lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		-- Enhanced Elixir setup
		require("lspconfig").elixirls.setup({
			capabilities = capabilities,
			cmd = { "elixir-ls" },
			settings = {
				elixirLS = {
					-- Dialyzer is disabled by default
					dialyzerEnabled = false,
					-- Enable or disable showing docs on hover
					fetchDeps = false,
					-- Enable or disable showing docs on hover
					docsAtPoint = "ExDoc",
				},
			},
		})

		-- Python setup
		require("lspconfig").pyright.setup({
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace",
					},
				},
			},
		})

		-- Rust setup
		require("lspconfig").rust_analyzer.setup({
			capabilities = capabilities,
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
					cargo = {
						loadOutDirsFromCheck = true,
					},
					procMacro = {
						enable = true,
					},
				},
			},
		})

		-- C/C++ setup
		require("lspconfig").clangd.setup({
			capabilities = capabilities,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--fallback-style=Google",
			},
		})

		-- JSON setup (simplified without schemastore)
		require("lspconfig").jsonls.setup({
			capabilities = capabilities,
			settings = {
				json = {
					validate = { enable = true },
				},
			},
		})

		-- CSS setup
		require("lspconfig").cssls.setup({
			capabilities = capabilities,
			settings = {
				css = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		})

		-- HTML setup
		require("lspconfig").html.setup({
			capabilities = capabilities,
			settings = {
				html = {
					format = {
						templating = true,
						wrapLineLength = 120,
						wrapAttributes = "auto",
					},
				},
			},
		})

		-- YAML setup
		require("lspconfig").yamlls.setup({
			capabilities = capabilities,
			settings = {
				yaml = {
					schemas = {
						["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
					},
				},
			},
		})

		-- Markdown setup
		require("lspconfig").marksman.setup({
			capabilities = capabilities,
		})

		-- Docker setup
		require("lspconfig").dockerls.setup({
			capabilities = capabilities,
		})

		-- nvim-cmp setup for autocompletion
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- Enhanced diagnostic config for better visuals
		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "●",
					[vim.diagnostic.severity.WARN] = "●",
					[vim.diagnostic.severity.INFO] = "●",
					[vim.diagnostic.severity.HINT] = "●",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
				},
			},
			underline = true,
			virtual_text = {
				spacing = 4,
				prefix = "●",
			},
		})

		-- Auto-format on save for supported file types
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.lua", "*.go", "*.rs", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx" },
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})

		-- Key mappings for LSP
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<space>f", vim.lsp.buf.format, opts)
				vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})
	end,
}
