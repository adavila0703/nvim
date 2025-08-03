local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

-- primeagen
keymap.set("n", "n", "nzzzv", { desc = "Move to next search item" })
keymap.set("n", "N", "Nzzzv", { desc = "Move to previous search item" })
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over visual selection" })
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open tmux sessionizer" }) -- not working for some reason
keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename all instances" })

-- move command
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tab managment
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- git / github
keymap.set("n", "<leader>gv", ":LazyGit<CR>", { desc = "Open LazyGit" })
keymap.set("n", "<leader>gb", ":Gitsigns blame<CR>", { desc = "Blame" })
keymap.set("n", "<leader>gc", ":CopilotChat<CR>", { desc = "Open Copilot Chat" })
keymap.set("n", "<leader>ge", ":Copilot enable", { desc = "Enables Copilot" })
keymap.set("n", "<leader>gd", ":Copilot disable", { desc = "Disables Copilot" })

-- nvim-tree
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })                         -- toggle file explorer
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })                     -- collapse file explorer
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })                       -- refresh file explorer

-- lsp coolness
keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
keymap.set("n", "gc", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Show hover doc" })
keymap.set("n", "<leader>cs", function() vim.lsp.buf.workspace_symbol() end, { desc = "Search workspace symbols" })
keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, { desc = "Find references" })
keymap.set("n", "<leader>cn", function() vim.lsp.buf.rename() end, { desc = "Rename" })
keymap.set("n", "<leader>ch", function() vim.lsp.buf.signature_help() end, { desc = "Signature help" })
keymap.set("n", "<leader>cdo", function() vim.diagnostic.open_float() end, { desc = "Open diagnostics" })
keymap.set("n", "<leader>cdn", function() vim.diagnostic.goto_next() end, { desc = "Next diagnostic" })
keymap.set("n", "<leader>cdp", function() vim.diagnostic.goto_prev() end, { desc = "Previous diagnostic" })

-- utils
keymap.set("n", "<leader>yf", ":let @+ = expand('%:p')<CR>", { desc = "Yank file path to clipboard" })

-- Enhanced folding keymaps
keymap.set("n", "za", "za", { desc = "Toggle fold under cursor" })
keymap.set("n", "zA", "zA", { desc = "Toggle fold under cursor recursively" })
keymap.set("n", "zo", "zo", { desc = "Open fold under cursor" })
keymap.set("n", "zO", "zO", { desc = "Open fold under cursor recursively" })
keymap.set("n", "zc", "zc", { desc = "Close fold under cursor" })
keymap.set("n", "zC", "zC", { desc = "Close fold under cursor recursively" })
keymap.set("n", "zm", "zm", { desc = "Close all folds" })
keymap.set("n", "zM", "zM", { desc = "Close all folds recursively" })
keymap.set("n", "zr", "zr", { desc = "Open all folds" })
keymap.set("n", "zR", "zR", { desc = "Open all folds recursively" })
keymap.set("n", "zj", "zj", { desc = "Move to next fold" })
keymap.set("n", "zk", "zk", { desc = "Move to previous fold" })

-- Custom folding shortcuts
keymap.set("n", "<leader>zf", "za", { desc = "Toggle fold under cursor" })
keymap.set("n", "<leader>zF", "zA", { desc = "Toggle fold under cursor recursively" })
keymap.set("n", "<leader>zo", "zo", { desc = "Open fold under cursor" })
keymap.set("n", "<leader>zc", "zc", { desc = "Close fold under cursor" })
keymap.set("n", "<leader>zM", "zM", { desc = "Close all folds" })
keymap.set("n", "<leader>zR", "zR", { desc = "Open all folds" })
keymap.set("n", "<leader>zj", "zj", { desc = "Next fold" })
keymap.set("n", "<leader>zk", "zk", { desc = "Previous fold" })

-- Visual mode folding
keymap.set("v", "<leader>zf", "zf", { desc = "Create fold from visual selection" })
keymap.set("v", "<leader>zd", "zd", { desc = "Delete fold under cursor" })
