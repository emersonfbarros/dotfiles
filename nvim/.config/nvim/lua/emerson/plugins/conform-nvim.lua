return {
  'stevearc/conform.nvim',
  cmd = 'ConformInfo',
  keys = {
    {
      '<leader>cp',
      mode = { 'n', 'v' },
      function()
        require('conform').format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end,
      desc = '[C]ode [P]retty',
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      css = { 'prettier' },
      cs = { 'csharpier' },
      html = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      graphql = { 'prettier' },
      lua = { 'stylua' },
      python = { 'black' },
      sh = { 'shellcheck' },
      proto = { 'buf' },
    },
    formatters = {
      csharpier = {
        command = 'dotnet-csharpier',
        args = { '--write-stdout' },
      },
    },
    format_on_save = nil,
  },
}
