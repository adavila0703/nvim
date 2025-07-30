vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

vim.o.statuscolumn = "%-4l %-2r %s"

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
-- :h autoindent + enter
-- this will give you info on the options

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false

-- long undos
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- search
-- opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.scrolloff = 8
opt.updatetime = 50

-- set leader key
vim.g.mapleader = " "

-- Enhanced folding configuration
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"  -- Disabled for UFO compatibility
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"  -- Better fold text
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99  -- Start with all folds open
vim.opt.foldnestmax = 4
vim.opt.fillchars = vim.opt.fillchars + "foldopen:▾,foldclose:▸,foldsep:│"  -- Better fold indicators

-- Alternative: Fast indent-based folding (uncomment to use)
-- vim.opt.foldmethod = "indent"
-- vim.opt.foldcolumn = "1"
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.fillchars = vim.opt.fillchars + "foldopen:▾,foldclose:▸,foldsep:│"

-- Alternative: Manual folding with markers (uncomment to use)
-- vim.opt.foldmethod = "marker"
-- vim.opt.foldmarker = "{{{,}}}"
-- vim.opt.foldcolumn = "1"
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.fillchars = vim.opt.fillchars + "foldopen:▾,foldclose:▸,foldsep:│"
