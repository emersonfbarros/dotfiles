return {
  'RRethy/vim-illuminate',
  event = 'LspAttach',
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
      },
      min_count_to_highlight = 2,
    }
  end,
}
