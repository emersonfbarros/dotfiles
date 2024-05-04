return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = {
      {'williamboman/mason.nvim', lazy = true, opts = {}},
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      { 'folke/neodev.nvim', opts = {}, lazy = true },
      {
        'j-hui/fidget.nvim',
        opts = {
          integration = {
            ['nvim-tree'] = {
              enable = false,
            },
          },
        },
        lazy = true,
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('nvim-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
          end

          local telescope_cmd = function(builtin)
            return '<cmd>Telescope ' .. builtin .. '<CR>'
          end

          map('gd', telescope_cmd 'lsp_definitions', '[G]oto [D]efinition')
          map('gr', telescope_cmd 'lsp_references', '[G]oto [R]eferences')
          map('gI', telescope_cmd 'lsp_implementations', '[G]oto [I]mplementation')
          map('gD', telescope_cmd 'lsp_type_definitions', '[G]oto Type [D]efinition')
          map('gC', vim.lsp.buf.declaration, '[G]oto De[c]laration')
          map('<leader>cs', telescope_cmd 'lsp_document_symbols', '[C]ode doc [S]ymbols')
          map('<leader>cS', telescope_cmd 'lsp_dynamic_workspace_symbols', '[C]ode workspace [S]ymbols')
          map('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
          map(']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
          map('<leader>m', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        gopls = {
          gofumpt = true,
          codelenses = {
            gc_details = false,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          analyses = {
            fieldalignment = true,
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
          semanticTokens = true,
        },
        golangci_lint_ls = {},
        pyright = {
          single_file_support = true,
          settings = {
            pyright = {
              disableLanguageServices = false,
              disableOrganizeImports = false,
            },
            python = {
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = 'workspace', -- openFilesOnly, workspace
                typeCheckingMode = 'basic', -- off, basic, strict
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        omnisharp = {
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
        tsserver = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              codeLens = {
                enable = true,
              },
            },
          },
        },
        dockerls = {},
        docker_compose_language_service = {},
        bashls = {},
        jsonls = {},
        taplo = {
          keys = {
            {
              'K',
              function()
                if vim.fn.expand '%:t' == 'Cargo.toml' and require('crates').popup_available() then
                  require('crates').show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = 'Show Crate Documentation',
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      require('mason').setup()

      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers or {}),
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            -- preventing duplicated server because typescript-tools plugin
            if server_name == 'tsserver' then
              return
            end

            if server.name == 'gopls' then
              if not server.server_capabilities.semanticTokensProvider then
                local semantic = server.config.capabilities.textDocument.semanticTokens
                server.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end

            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
