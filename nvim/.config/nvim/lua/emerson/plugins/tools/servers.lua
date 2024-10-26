---@return table
return {
  ts_ls = {},
  dockerls = {},
  docker_compose_language_service = {},
  bashls = {},
  jsonls = {},
  omnisharp = {
    handlers = {
      ['textDocument/definition'] = function(...)
        return require('omnisharp_extended').handler(...)
      end,
    },
    keys = {
      {
        'gd',
        require('omnisharp_extended').telescope_lsp_definitions(),
        desc = 'Goto Definition',
      },
    },
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
  },
  marksman = {},
  gopls = {
    settings = {
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
          rangeVariableTypes = true,
          parameterNames = true,
          constantValues = true,
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          functionTypeParameters = true,
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
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        hint = {
          enable = true,
        },
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
