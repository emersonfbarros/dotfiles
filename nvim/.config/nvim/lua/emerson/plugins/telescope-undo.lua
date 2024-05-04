return {
  -- Separated from telescope due to lazy loading reasons
  'debugloop/telescope-undo.nvim',
  dependencies = {
    {
      'nvim-telescope/telescope.nvim',
      dependencies = 'nvim-lua/plenary.nvim',
    },
  },
  keys = {
    {
      '<leader>su',
      '<cmd>Telescope undo<CR>',
      desc = '[S]earch [U]ndo history',
    },
  },
  opts = {
    extensions = { undo = {} },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension 'undo'
  end,
}
