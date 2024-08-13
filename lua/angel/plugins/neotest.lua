return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/fixcursorhold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"marilari88/neotest-vitest",
			"nvim-neotest/neotest-plenary",
			"fredrikaverpil/neotest-golang",
			"nvim-neotest/neotest-jest",
		},
		config = function()
			local neotest = require("neotest")

			neotest.setup({
				adapters = {
					require("neotest-vitest"),
					require("neotest-plenary").setup({
						-- this is my standard location for minimal vim rc
						-- in all my projects
						min_init = "./scripts/tests/minimal.vim",
					}),
					require("neotest-golang"),
					require("neotest-jest")({
						jestcommand = "npm test --",
						jestconfigfile = "custom.jest.config.ts",
						env = { ci = true },
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
				},
			})

			vim.keymap.set("n", "<leader>tto", ":Neotest output-panel<CR>", { desc = "Open output panel" })

			vim.keymap.set("n", "<leader>ttc", function()
				neotest.run.run()
			end, { desc = "run test under cursor" })

			-- vim.keymap.set("n", "<leader>tf", function()
			--   neotest.run.file()
			-- end, { desc = "Run test file" })
			--
			-- vim.keymap.set("n", "<leader>ts", function()
			--   neotest.run.suite()
			-- end, { desc = "Run test suite" })
		end,
	},
}
