return {
  'tpope/vim-fugitive',
  cmd = {
    'G',
    'Git',
    'Gdiffsplit',
    'Gread',
    'Gwrite',
    'Ggrep',
    'GMove',
    'GDelete',
    'GBrowse',
    'GRemove',
    'GRename',
    'Glgrep',
    'Gedit',
  },
  keys = {
    vim.keymap.set({ 'n', 'v' }, '<leader>G', ':vertical G<CR>', { desc = 'Git Fugitive', silent = true }),
  },
  ft = { 'fugitive' },
}
