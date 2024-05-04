return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
  },
  config = function()
    -- skip backwards compatibility routines and speed up loading
    vim.g.skip_ts_context_commentstring_module = true

    local treesitter = require 'nvim-treesitter.configs'

    treesitter.setup { -- enable syntax highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = {
        'json',
        'javascript',
        'typescript',
        'tsx',
        'python',
        'c_sharp',
        'proto',
        'yaml',
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
        'make',
        'toml',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    }
  end,
}
