return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { 'n', 'v' },
      ['g'] = { name = '+goto' },
      ['gs'] = { name = '+surround' },
      [']'] = { name = '+next' },
      ['['] = { name = '+prev' },
      ['<leader>c'] = { name = '+[C]ode' },
      ['<leader>cc'] = { name = '+[C]opilotChat' },
      ['<leader>d'] = { name = '+[D]ebug' },
      ['<leader>e'] = { name = '+[E]xplorer' },
      ['<leader>f'] = { name = '+[F]ind' },
      ['<leader>g'] = { name = '+[G]it' },
      ['<leader>gh'] = { name = '+[H]unks' },
      ['<leader>G'] = { name = '+[G]o' },
      ['<leader>h'] = { name = '+[H]arpoon' },
      ['<leader>s'] = { name = '+[S]earch' },
      ['<leader>t'] = { name = '+Neo[T]est' },
    },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
