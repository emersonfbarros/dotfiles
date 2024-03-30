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
      capabilities = capabilities,
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
          quotePreference = 'single',
          importModuleSpecifierEnding = 'minimal',
          importModuleSpecifierPreference = 'relative',
        },
      },
    }

    vim.keymap.set('n', '<leader>to', '<cmd>TSToolsOrganizeImports<cr>', { desc = ' TS Organize Imports' })
    vim.keymap.set('n', '<leader>ts', '<cmd>TSToolsSortImports<cr>', { desc = ' TS Sort Imports' })
    vim.keymap.set('n', '<leader>tru', '<cmd>TSToolsRemoveUnused<cr>', { desc = ' TS Removed Unused' })
    vim.keymap.set('n', '<leader>td', '<cmd>TSToolsGoToSourceDefinition<cr>', { desc = ' TS Go To Source Definition' })
    vim.keymap.set('n', '<leader>tri', '<cmd>TSToolsRemoveUnusedImports<cr>', { desc = ' TS Removed Unused Imports' })
    vim.keymap.set('n', '<leader>tf', '<cmd>TSToolsFixAll<cr>', { desc = ' TS Fix All' })
    vim.keymap.set('n', '<leader>tia', '<cmd>TSToolsAddMissingImports<cr>', { desc = ' TS Add Missing Imports' })
    vim.keymap.set('n', '<leader>trf', '<cmd>TSToolsRenameFile<cr>', { desc = 'TS Rename File' })
  end,
}
