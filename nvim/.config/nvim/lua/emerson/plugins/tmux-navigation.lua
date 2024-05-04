return {
  'alexghergh/nvim-tmux-navigation',
  keys = {
    {
      '<C-h>',
      function()
        require('nvim-tmux-navigation').NvimTmuxNavigateLeft()
      end,
    },
    {
      '<C-j>',
      function()
        require('nvim-tmux-navigation').NvimTmuxNavigateDown()
      end,
    },
    {
      '<C-k>',
      function()
        require('nvim-tmux-navigation').NvimTmuxNavigateUp()
      end,
    },
    {
      '<C-l>',
      function()
        require('nvim-tmux-navigation').NvimTmuxNavigateRight()
      end,
    },
  },
  config = function()
    require('nvim-tmux-navigation').setup {
      disable_when_zoomed = true, -- defaults to false
    }
  end,
}
