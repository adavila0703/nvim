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
          "ts_ls",
          "lua_ls",
          "jsonls",
          "html",
          "cssls",
          "gopls",
          "pyright",
          "tailwindcss",
          "elixirls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- Autocompletion plugins
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Core LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      vim.opt.completeopt = { "menuone", "noselect", "popup" }

      local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if cmp_ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

             local on_attach = function(client, bufnr)
         local opts = { noremap = true, silent = true, buffer = bufnr }

         -- Custom go to definition that handles duplicates and jumps directly
         vim.keymap.set("n", "gd", function()
           local params = vim.lsp.util.make_position_params()
           vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, config)
             if err then
               vim.notify("Error: " .. err.message, vim.log.levels.ERROR)
               return
             end
             
             if not result or vim.tbl_isempty(result) then
               vim.notify("No definition found", vim.log.levels.INFO)
               return
             end

             -- Handle both Location and LocationLink
             local locations = {}
             if result[1] and result[1].targetUri then
               -- LocationLink format
               for _, link in ipairs(result) do
                 table.insert(locations, {
                   uri = link.targetUri,
                   range = link.targetRange or link.targetSelectionRange
                 })
               end
             else
               -- Location format
               locations = result
             end

             -- Remove duplicates based on uri and range
             local unique_locations = {}
             local seen = {}
             for _, loc in ipairs(locations) do
               local key = loc.uri .. ":" .. loc.range.start.line .. ":" .. loc.range.start.character
               if not seen[key] then
                 seen[key] = true
                 table.insert(unique_locations, loc)
               end
             end

             -- Jump directly if only one unique location
             if #unique_locations == 1 then
               vim.lsp.util.jump_to_location(unique_locations[1], "utf-8")
             else
               -- Show quickfix list if multiple locations
               vim.lsp.util.locations_to_items(unique_locations, "utf-8")
               vim.cmd("copen")
             end
           end)
         end, opts)
         
         vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
         vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
         vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
         vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
         vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
         vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
         vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
         vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)

         vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
         vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
         vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
      end

      local servers = {
        "ts_ls",
        "lua_ls",
        "jsonls",
        "html",
        "cssls",
        "gopls",
        "pyright",
        "tailwindcss",
        "elixirls",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
            },
          },
        },
      })

      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })
    end,
  },
}