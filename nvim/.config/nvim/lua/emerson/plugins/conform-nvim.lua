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
      go = { 'goimports-reviser', 'gofumpt', 'golines' },
      javascript = { 'biome' },
      typescript = { 'biome' },
      javascriptreact = { 'biome' },
      typescriptreact = { 'biome' },
      css = { 'prettier' },
      html = { 'prettier' },
      json = { 'jq' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      lua = { 'stylua' },
      sh = { 'shfmt' },
      proto = { 'buf' },
    },
    format_on_save = nil,
  },
}
