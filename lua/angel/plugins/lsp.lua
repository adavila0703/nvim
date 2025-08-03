return {
  -- Mason core plugin
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  -- Mason-LSP bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",     -- ✅ New name for TypeScript LSP
          "lua_ls",    -- Lua
          "jsonls",    -- JSON
          "eslint",    -- ESLint
          "html",      -- HTML
          "cssls",     -- CSS
          "gopls",     -- Go
          "pyright",   -- Python
          "tailwindcss", -- Tailwind CSS
          "elixirls",  -- Elixir
        },
        automatic_installation = true,
      })
    end,
  },

  -- Core LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Optional: improve capabilities with cmp_nvim_lsp (if installed)
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        ok and cmp_nvim_lsp.default_capabilities() or {}
      )

      local servers = {
        "ts_ls",
        "lua_ls",
        "jsonls",
        "eslint",
        "html",
        "cssls",
        "gopls",
        "pyright",
        "tailwindcss",
        "elixirls",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end
    end,
  },
}
