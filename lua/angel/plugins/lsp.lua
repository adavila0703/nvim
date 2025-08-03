return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    vim.opt.synmaxcol = 500

    vim.api.nvim_create_autocmd("InsertEnter", {
      pattern = "*",
      callback = function(event)
        vim.schedule(function()
          vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
        end)
      end,
    })

    vim.api.nvim_create_autocmd("InsertLeave", {
      pattern = "*",
      callback = function(event)
        vim.schedule(function()
          vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        end)
      end,
    })

    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = { buffer = event.buf, silent = true }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end,
    })

    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "tsserver", -- still used by mason
        "eslint",
        "jsonls",
        "cssls",
        "html",
      },
      -- Add this line to disable automatic setup
      automatic_installation = true,
      -- Add this to disable automatic enable
      automatic_enable = false,
      handlers = {
        -- This will be called for each installed server
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      },
    })

    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local function setup(server, config)
      local merged = vim.tbl_deep_extend("force", {
        capabilities = capabilities,
      }, config or {})

      local ok, err = pcall(function()
        lspconfig[server].setup(merged)
      end)
      if not ok then
        vim.notify("Failed to setup LSP server " .. server .. ": " .. tostring(err), vim.log.levels.WARN)
      end
    end

    -- TypeScript (tsserver renamed to ts_ls)
    setup("ts_ls", {
      settings = {
        typescript = {
          tsserver = {
            maxTsServerMemory = 1024,
            disableAutomaticTypeAcquisition = true,
            watchOptions = {
              watchFile = "useFsEvents",
              watchDirectory = "useFsEvents"
            },
            enableTracing = false,
            logVerbosity = "off",
            maxNodeModuleJsDepth = 1,
          },
        },
        javascript = {
          tsserver = {
            maxTsServerMemory = 1024,
            disableAutomaticTypeAcquisition = true,
            enableTracing = false,
            logVerbosity = "off",
            maxNodeModuleJsDepth = 1,
          },
        },
        typescriptInlayHints = {
          includeInlayParameterNameHints = "none",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayEnumMemberValueHints = false,
        },
        javascriptInlayHints = {
          includeInlayParameterNameHints = "none",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayEnumMemberValueHints = false,
        },
      },
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    })

    -- ESLint
    setup("eslint", {
      settings = {
        run = "onSave",
      },
    })

    -- JSON, CSS, HTML
    setup("jsonls")
    setup("cssls")
    setup("html")

    -- Lua
    setup("lua_ls", {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              vim.env.VIMRUNTIME,
            },
          },
        },
      },
    })

    vim.opt.completeopt = { "menu", "menuone", "noinsert" }

    local cmp = require("cmp")

    cmp.setup({
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.abort(),
      }),
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
    })
  end,
}
