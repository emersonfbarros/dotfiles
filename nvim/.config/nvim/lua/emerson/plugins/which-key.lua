return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = { spelling = true },
    defaults = {},
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader>G', group = '[G]o' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>cc', group = '[C]opilot[C]hat' },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>e', group = '[E]xplorer' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>g', group = '[G]it' },
        { '<leader>gh', group = '[H]unks' },
        { '<leader>h', group = '[H]arpoon' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = 'Neo[T]est' },
        { '[', group = 'prev' },
        { ']', group = 'next' },
        { 'g', group = 'goto' },
        { 'gs', group = 'surround' },
      },
    },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)
  end,
}
