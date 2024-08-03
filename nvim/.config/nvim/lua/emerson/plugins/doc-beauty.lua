return {
  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = {},
    ft = { 'org', 'norg' },
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    name = 'render-markdown',
    config = function()
      require('render-markdown').setup {}
    end,
    ft = { 'markdown' },
  },
}
