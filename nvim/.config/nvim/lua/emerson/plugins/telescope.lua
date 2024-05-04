return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    local telescope = require 'telescope'
    telescope.load_extension 'fzf'

    telescope.setup {
      defaults = {
        prompt_prefix = ' ',
        selection_caret = ' ',
      },
      pickers = {
        buffers = { theme = 'dropdown', previewer = false },
      },
    }
  end,
  keys = {
    -- Some stuff
    {
      '<leader><leader>',
      function()
        require('telescope.builtin').buffers()
      end,
      desc = '[ ] Find existing buffers',
    },
    {
      '<leader>/',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = '[/] Fuzzily search in current buffer',
    },
    -- Search stuff
    {
      '<leader>s/',
      function()
        require('telescope.builtin').live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>sf',
      function()
        require('telescope.builtin').find_files()
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>sg',
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sw',
      function()
        require('telescope.builtin').grep_string()
      end,
      desc = '[S]earch current [W]ord',
    },
    {
      '<leader>sd',
      function()
        require('telescope.builtin').diagnostics { bufnr = 0 }
      end,
      desc = '[S]earch document [D]iagnostics',
    },
    {
      '<leader>sD',
      function()
        require('telescope.builtin').diagnostics()
      end,
      desc = '[S]earch workspace [D]iagnostics',
    },
    {
      '<leader>sk',
      function()
        require('telescope.builtin').keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sh',
      function()
        require('telescope.builtin').help_tags()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sr',
      function()
        require('telescope.builtin').registers()
      end,
      desc = '[S]earch [R]egisters',
    },
    -- Git stuff
    {
      '<leader>gf',
      function()
        require('telescope.builtin').git_files()
      end,
      desc = '[G]it [F]iles',
    },
    {
      '<leader>gc',
      function()
        require('telescope.builtin').git_commits()
      end,
      desc = '[G]it [C]ommits',
    },
    {
      '<leader>gs',
      function()
        require('telescope.builtin').git_status()
      end,
      desc = '[G]it [S]tatus',
    },
    {
      '<leader>gS',
      function()
        require('telescope.builtin').git_stash()
      end,
      desc = '[G]it [S]tashes',
    },
  },
}
