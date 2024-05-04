return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle', 'NvimTreeCollapse' },
  keys = {
    {
      '<leader>ee',
      '<cmd>NvimTreeToggle<CR>',
      desc = '[E]xplorer Op[E]n',
    },
    {
      '<leader>ef',
      '<cmd>NvimTreeFindFileToggle<CR>',
      desc = '[E]xplorer on [F]ile',
    },
    {
      '<leader>ec',
      '<cmd>NvimTreeCollapse<CR>',
      desc = '[E]xplorer [C]ollapse',
    },
  },
  config = function()
    local nvimtree = require 'nvim-tree'

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- configure nvim-tree
    nvimtree.setup {
      view = {
        width = 38,
        relativenumber = false,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
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
  end,
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.uv.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require 'nvim-tree'
      end
    end
  end,
}
