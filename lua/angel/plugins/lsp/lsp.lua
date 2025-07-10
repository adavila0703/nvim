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

		-- Basic Mason setup
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",    -- TypeScript/JavaScript
				"eslint",   -- ESLint
				"gopls",
			},
			automatic_installation = true,
		})

		-- TypeScript setup
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

		-- ESLint setup
		require("lspconfig").eslint.setup({
			capabilities = capabilities,
			root_dir = require("lspconfig").util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json"),
			settings = {
				workingDirectory = { mode = "auto" },
			},
		})

		require("lspconfig").gopls.setup({
			capabilities = capabilities,
		})

		require("lspconfig").lua_ls.setup({
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

		-- Diagnostic config for better visuals
		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
