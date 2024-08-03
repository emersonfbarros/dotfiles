return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  lazy = true,
  config = function()
    local tst = require 'typescript-tools'

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    tst.setup {
      capabilities = vim.tbl_deep_extend('force', {}, capabilities, tst.capabilities or {}),
      settings = {
        separate_diagnostic_server = true,
        composite_mode = 'separate_diagnostic',
        publish_diagnostic_on = 'insert_leave',
        tsserver_logs = 'verbose',
        disable_member_code_lens = true,
        jsx_close_tag = {
          enable = true,
          filetypes = { 'javascriptreact', 'typescriptreact' },
        },
        tsserver_file_preferences = {
          quotePreference = 'auto',
          importModuleSpecifierEnding = 'minimal',
          importModuleSpecifierPreference = 'shortest',
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    }

    local js_actions = function()
      vim.ui.select({
        'TSToolsOrganizeImports',
        'TSToolsSortImports',
        'TSToolsRemoveUnusedImports',
        'TSToolsRemoveUnused',
        'TSToolsAddMissingImports',
        'TSToolsFixAll',
        'TSToolsGoToSourceDefinition',
        'TSToolsRenameFile',
        'TSToolsFileReferences',
      }, {
        prompt = 'TS/JS Actions',
      }, function(choice)
        if choice then
          vim.cmd(choice)
        end
      end)
    end

    vim.keymap.set('n', '<leader>js', js_actions, { desc = 'TS/JS Action' })
  end,
}
