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

		-- Mason setup to manage LSP servers
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"ts_ls",
				"clangd",
				"prismals", -- Added Prisma
			},
		})

		-- setup the lsp this way or you get weird issues with snippets on windows
		require("lspconfig").ts_ls.setup({
			capabilities = vim.tbl_extend("keep", capabilities, {
				textDocument = {
					completion = {
						completionItem = {
							snippetSupport = false, -- Disable snippet support
						},
					},
				},
			}),
		})

		require("lspconfig").gopls.setup({
			capabilities = capabilities,
		})

		require("lspconfig").rust_analyzer.setup({
			capabilities = capabilities,
		})

		require("lspconfig").clangd.setup({
			capabilities = capabilities,
		})

		require("lspconfig").tailwindcss.setup({
			cmd = { 'tailwindcss-language-server', '--stdio' },
			filetypes = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
			root_dir = require('lspconfig').util.root_pattern('tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js', '.git'),
			settings = {
				tailwindCSS = {
					classAttributes = { 'class', 'className', 'ngClass', 'v-bind:class' }
				}
			}
		})

		-- nvim-cmp setup for autocompletion
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
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
				{ name = "luasnip" }, -- For luasnip users.
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
