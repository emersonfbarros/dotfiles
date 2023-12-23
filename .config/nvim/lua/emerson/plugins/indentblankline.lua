return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  main = 'ibl',
  opts = {
    indent = {
      char = '▏',
      -- tab_char = '▏',
      -- highlight = 'IndentBlanklineChar',
    },
    -- whitespace = {
    --   highlight = 'IndentBlanklineSpaceChar',
    -- },
    scope = {
      -- char = '▏',
      -- show_end = false,
      -- show_start = false,
      -- include = {
      --   node_type = {
      --     ['*'] = { '*' },
      --   },
      -- },
      enabled = false,
    },
    exclude = {
      filetypes = {
        'help',
        'lazy',
        'mason',
        'terminal',
        'nofile',
        'NvimTree',
      },
    },
  },
}
