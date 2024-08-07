vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
-- keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- git / github
keymap.set("n", "<leader>gv", ":LazyGit<CR>", { desc = "Open LazyGit" })
keymap.set("n", "<leader>gb", ":Gitsigns blame<CR>", { desc = "Blame" })
keymap.set("n", "<leader>gc", ":CopilotChat<CR>", { desc = "Open Copilot Chat" })

local augroup = vim.api.nvim_create_augroup
local AngelsGroup = augroup("AngelsGroup", {})
local autocmd = vim.api.nvim_create_autocmd
autocmd("LspAttach", {
  group = AngelsGroup,
  callback = function(e)
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, { desc = "Go to definition", buffer = e.buf })
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, { desc = "Show hover doc", buffer = e.buf })
    vim.keymap.set("n", "<leader>vws", function()
      vim.lsp.buf.workspace_symbol()
    end, { desc = "Search workspace symbols", buffer = e.buf })
    vim.keymap.set("n", "<leader>vd", function()
      vim.diagnostic.open_float()
    end, { desc = "Open diagnostics", buffer = e.buf })
    vim.keymap.set("n", "<leader>vca", function()
      vim.lsp.buf.code_action()
    end, { desc = "Code action", buffer = e.buf })
    vim.keymap.set("n", "<leader>vrr", function()
      vim.lsp.buf.references()
    end, { desc = "Find references", buffer = e.buf })
    vim.keymap.set("n", "<leader>vrn", function()
      vim.lsp.buf.rename()
    end, { desc = "Rename", buffer = e.buf })
    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, { desc = "Signature help", buffer = e.buf })
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_next()
    end, { desc = "Next diagnostic", buffer = e.buf })
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_prev()
    end, { desc = "Previous diagnostic", buffer = e.buf })
  end,
})
