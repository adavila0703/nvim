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

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart =0
vim.opt.foldnestmax = 4
