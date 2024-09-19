return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/nvim-cmp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
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

		-- nvim-cmp setup for autocompletion
		cmp.setup({
			snippet = {
				expand = function(_) end, -- Disable snippets globally
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- LSP completions
				{ name = "buffer" }, -- Buffer completions
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
