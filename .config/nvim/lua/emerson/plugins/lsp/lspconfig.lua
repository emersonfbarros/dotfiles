return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'hrsh7th/cmp-nvim-lsp',
    -- Useful status updates for LSP
    -- Additional lua configuration, makes nvim stuff amazing!
    { 'folke/neodev.nvim', lazy = true, opts = {} },
  },
  config = function()
    local lsputils = require 'emerson.utils.lsp'
    local servers = require 'emerson.utils.servers'

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        -- [[ Custom setup for LSPs ]]
        if server_name == 'tsserver' then
          return
        end
        if server_name == 'pyright' then
          vim.keymap.set('n', '<leader>po', ':PyrightOrganizeImports<CR>', { desc = 'Python Organize Imports', silent = true })
        end
        require('lspconfig')[server_name].setup {
          capabilities = lsputils.capabilities(),
          on_attach = lsputils.on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end,
    }

    -- Install debugers, linters and formatters with mason
    local mason_tool_installer = require 'mason-tool-installer'
    mason_tool_installer.setup {
      ensure_installed = {
        'prettier', -- prettier formatter
        'stylua', -- lua formatter
        'eslint_d', -- js/ts linter
        'js-debug-adapter',
        'java-debug-adapter',
        'jdtls', -- java lsp
        'google-java-format',
        'black', -- python formatter
        'flake8', -- python linter
        'debugpy', --python debuger
        'golangci-lint',
      },
    }
  end,
}
