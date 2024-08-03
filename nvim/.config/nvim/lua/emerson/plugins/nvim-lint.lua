return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPost', 'BufWritePost', 'InsertLeave' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      go = { 'golangcilint' },
      javascript = { 'eslint_d', 'biomejs' },
      typescript = { 'eslint_d', 'biomejs' },
      javascriptreact = { 'eslint_d', 'biomejs' },
      typescriptreact = { 'eslint_d', 'biomejs' },
      proto = { 'buf_lint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>cl', function()
      lint.try_lint()
    end, { desc = '[C]ode [L]int' })
  end,
}
