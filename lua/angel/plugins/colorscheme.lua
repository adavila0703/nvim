-- sets up color scheme for nvim

return {
	"marko-cerovac/material.nvim",
	config = function()
		-- Set the material style to palenight
		vim.g.material_style = "palenight"

		-- Enable the colorscheme and configure the settings
		require("material").setup({
			contrast = {
				terminal = false, -- Enable contrast for the built-in terminal
				sidebars = false, -- Enable contrast for sidebar-like windows
				floating_windows = false, -- Enable contrast for floating windows
				cursor_line = false, -- Enable darker background for the cursor line
				lsp_virtual_text = false, -- Enable contrasted background for LSP virtual text
				non_current_windows = false, -- Enable contrasted background for non-current windows
				filetypes = {}, -- Specify which filetypes get the contrasted background
			},
			styles = { -- Customize the styles
				comments = { italic = true },
				strings = { bold = true },
				keywords = { underline = false },
				functions = { bold = true, undercurl = false },
				variables = {},
				operators = {},
				types = {},
			},
			plugins = { -- Enable plugin support
				"nvim-tree",
				"telescope",
				"nvim-cmp",
				"gitsigns",
				"lspsaga",
				"which-key",
			},
			disable = {
				colored_cursor = false, -- Disable colored cursor
				borders = false, -- Disable borders between vertically split windows
				background = false, -- Prevent the theme from setting the background
				term_colors = false, -- Prevent the theme from setting terminal colors
				eob_lines = false, -- Hide end-of-buffer lines
			},
			high_visibility = {
				lighter = false, -- Enable higher contrast text for lighter style
				darker = false, -- Enable higher contrast text for darker style
			},
			lualine_style = "default", -- Set Lualine style
			async_loading = true, -- Load parts of the theme asynchronously
			custom_colors = nil, -- Override default colors
			custom_highlights = {
				Normal = { fg = "#A6ACCD", bg = "#292D3E" },
				Comment = { fg = "#676E95", italic = true },
				Keyword = { fg = "#C792EA", underline = false },
				String = { fg = "#C3E88D", bold = true },
				Function = { fg = "#82AAFF", bold = true, undercurl = false },
				Variable = { fg = "#F07178" },
				Operator = { fg = "#A6ACCD" },
				Type = { fg = "#82AAFF" },
				LineNr = { fg = "#676E95" },
				CursorLine = { bg = "#292D3E" },
				CursorLineNr = { fg = "#A6ACCD" },
				-- Add any other highlight groups you want to customize
			},
		})

		vim.cmd("colorscheme material")
	end,
}
