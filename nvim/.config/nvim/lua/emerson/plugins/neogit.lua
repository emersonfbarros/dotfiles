return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  cmd = 'Neogit',
  keys = {
    { '<leader>gg', '<cmd>Neogit kind=vsplit<CR>', desc = '[G]it Neo[g]it' },
  },
  opts = {
    graph_style = 'unicode',
    signs = {
      hunk = { '', '' },
      item = { '', '' },
      section = { '', '' },
    },
  },
}
