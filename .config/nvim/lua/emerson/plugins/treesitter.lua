return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
    },
    config = function()
      -- import nvim-treesitter plugin

      local treesitter = require 'nvim-treesitter.configs'

      -- configure treesitter
      treesitter.setup { -- enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        -- enable indentation
        indent = { enable = true },
        -- ensure these language parsers are installed
        ensure_installed = {
          'json',
          'javascript',
          'typescript',
          'tsx',
          'java',
          'python',
          'yaml',
          'html',
          'css',
          'markdown',
          'markdown_inline',
          'bash',
          'lua',
          'vim',
          'sql',
          'dockerfile',
          'gitignore',
          'go',
          'gomod',
          'gowork',
          'gosum',
          'rust',
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = 'c-s',
            node_decremental = 'C-backspace',
          },
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      }
    end,
  },
}
