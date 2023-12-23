return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' },
  keys = {
    vim.keymap.set('n', '<leader>es', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle file explorer' }),
    vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFileToggle<CR>', { silent = true, desc = 'Toggle file explorer on current file' }),
  },
  config = function()
    local nvimtree = require 'nvim-tree'

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    -- vim.cmd [[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]]
    -- vim.cmd [[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]]

    -- configure nvim-tree
    nvimtree.setup {
      view = {
        width = 38,
        relativenumber = false,
      },
      -- renderer = {
      --   indent_markers = {
      --     enable = true,
      --   },
      -- },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
      git = {
        ignore = false,
      },
    }

    -- set keymaps
    vim.keymap.set('n', '<leader>ec', ':NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' }) -- collapse file explorer
    vim.keymap.set('n', '<leader>er', ':NvimTreeRefresh<CR>', { desc = 'Refresh file explorer' }) -- refresh file explorer
  end,
}
