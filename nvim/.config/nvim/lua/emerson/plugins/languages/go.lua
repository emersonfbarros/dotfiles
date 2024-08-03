return {
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    ---@type gopher.Config
    opts = {},
  },
  {
    'edolphin-ydf/goimpl.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      { '<leader>Gi', '<cmd>lua require"telescope".extensions.goimpl.goimpl{}<CR>', desc = '[G]o [I]mplement' },
    },
    config = function()
      require('telescope').load_extension 'goimpl'
    end,
  },
  {
    'maxandron/goplements.nvim',
    ft = 'go',
    opts = {},
  },
}
