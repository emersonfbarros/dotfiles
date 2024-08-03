return {
  'alexghergh/nvim-tmux-navigation',
  keys = {
    {
      '<C-h>',
      '<cmd>NvimTmuxNavigateLeft<CR>',
    },
    {
      '<C-j>',
      '<cmd>NvimTmuxNavigateDown<CR>',
    },
    {
      '<C-k>',
      '<cmd>NvimTmuxNavigateUp<CR>',
    },
    {
      '<C-l>',
      '<cmd>NvimTmuxNavigateRight<CR>',
    },
  },
  opts = {
    disable_when_zoomed = true, -- defaults to false
  },
}
