return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			winopts = {
				height = 0.85, -- window height
				width = 0.80, -- window width
				row = 0.30, -- window row position
				col = 0.50, -- window col position
				border = "rounded", -- border type: single | double | rounded | solid | shadow
				preview = {
					default = "bat", -- override the default previewer
					vertical = "up:45%", -- up | down | up:45% | down:45%
					horizontal = "right:60%", -- right | left | right:60% | left:60%
					layout = "horizontal", -- horizontal | vertical | flex
				},
			},
			fzf_opts = {
				["--ansi"] = "",
				["--prompt"] = " > ",
				["--info"] = "inline",
				["--height"] = "100%",
			},
		})

		local keymap = vim.keymap
		local fzf = require("fzf-lua")

		keymap.set("n", "<leader>ff", fzf.files, { desc = "Fzf Lua find files" })
		keymap.set("n", "<C-p>", fzf.git_files, { desc = "Fzf Lua git files" })
		keymap.set("n", "<leader>fw", function()
			local word = vim.fn.expand("<cword>")
			fzf.grep({ search = word })
		end, { desc = "Fzf Lua grep current word" })
		keymap.set("n", "<leader>fW", function()
			local word = vim.fn.expand("<cWORD>")
			fzf.grep({ search = word })
		end, { desc = "Fzf Lua grep current WORD" })
		keymap.set("n", "<leader>fs", function()
			fzf.grep({ search = vim.fn.input("Grep > ") })
		end, { desc = "Fzf Lua grep" })
		keymap.set("n", "<leader>vh", fzf.help_tags, { desc = "Fzf Lua help tags" })
	end,
}
