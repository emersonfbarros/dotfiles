return {
  'RRethy/vim-illuminate',
  event = 'VeryLazy',
  config = function()
    require('illuminate').configure {
      filetypes_denylist = {
        'dirbuf',
        'NeogitStatus',
        'NeogitCommitMessage',
        'neotest-summary',
        'neotest-output-panel',
        'lazy',
        'trouble',
        'mason',
        'help',
        'NvimTree',
      },
      min_count_to_highlight = 2,
    }
  end,
}
