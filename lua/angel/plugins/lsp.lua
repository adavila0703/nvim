return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path", -- Add path completions
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    -- Performance optimizations
    vim.opt.synmaxcol = 500 -- Limit syntax highlighting for long lines
    
    -- Disable inlay hints in insert mode for better performance
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

    -- Simple diagnostic keymaps
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>') 

    -- LSP keymaps when server attaches
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = {buffer = event.buf, silent = true}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end
    })

    -- Setup Mason first
    require('mason').setup({})

    -- Setup mason-lspconfig (disable automatic_enable to avoid compatibility issues)
    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls',
        'vtsls', -- Use vtsls instead of ts_ls
        'eslint',
        'gopls',
        'rust_analyzer',
        'pyright',
        'clangd',
        'jsonls',
        'cssls',
        'html',
        'yamlls',
        'marksman',
        'dockerls',
      },
      automatic_enable = false, -- Disable to avoid v2.0+ compatibility issues
    })

    -- Get LSP capabilities for cmp integration
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Configure servers manually with proper capabilities
    local lspconfig = require('lspconfig')
    
    -- Default server setup function
    local function setup_server(server_name, extra_config)
      local config = { capabilities = lsp_capabilities }
      if extra_config then
        config = vim.tbl_deep_extend('force', config, extra_config)
      end
      lspconfig[server_name].setup(config)
    end

    -- Setup vtsls (more stable than ts_ls)
    setup_server('vtsls', {
      settings = {
        vtsls = {
          experimental = {
            completion = {
              enableServerSideFuzzyMatch = true,
              entriesLimit = 20, -- Limit completions for performance
            },
          },
          typescript = {
            tsserver = {
              maxTsServerMemory = 2048, -- Reduce memory usage
              disableAutomaticTypeAcquisition = true,
              useSyntaxServer = "never",
            },
          },
          javascript = {
            tsserver = {
              maxTsServerMemory = 2048,
              disableAutomaticTypeAcquisition = true,
              useSyntaxServer = "never",
            },
          },
        },
      },
    })

    -- Setup eslint with performance optimizations
    setup_server('eslint', {
      settings = {
        run = "onSave", -- Only run on save for better performance
      },
    })

    -- Setup other servers
    setup_server('gopls')
    setup_server('rust_analyzer')
    setup_server('pyright')
    setup_server('clangd')
    setup_server('jsonls')
    setup_server('cssls')
    setup_server('html')
    setup_server('yamlls')
    setup_server('marksman')
    setup_server('dockerls')

    -- Lua LSP with custom settings
    setup_server('lua_ls', {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          diagnostics = {
            globals = {'vim'},
          },
          workspace = {
            library = {
              vim.env.VIMRUNTIME,
            }
          }
        }
      }
    })

    -- Set completeopt for better completion experience
    vim.opt.completeopt = {'menu', 'menuone', 'noinsert'}

    local cmp = require('cmp')

    cmp.setup({
      sources = {
        {name = 'nvim_lsp'},
        {name = 'luasnip'},
        {name = 'buffer'},
        {name = 'path'}, -- Add path completions
      },
      mapping = cmp.mapping.preset.insert({
        -- Navigate through completion items
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        
        -- Use Tab and Shift-Tab for navigation
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        
        -- Accept completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        
        -- Close completion
        ['<C-e>'] = cmp.mapping.abort(),
      }),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
    })
  end,
} 