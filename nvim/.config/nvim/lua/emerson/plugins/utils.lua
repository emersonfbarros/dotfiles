return {
  {
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
        desc = '[G]it [S]tash',
      },
    },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    config = function()
      local function db_completion()
        require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
      end
      vim.g.db_ui_save_location = vim.fn.stdpath 'config' .. require('plenary.path').path.sep .. 'db_ui'
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'sql',
        },
        command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'sql',
          'mysql',
          'plsql',
        },
        callback = function()
          vim.schedule(db_completion)
        end,
      })
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        '<leader>hl',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = '[H]arpoon [L]ist',
      },
      {
        '<leader>ha',
        function()
          require('harpoon'):list():append()
        end,
        desc = '[H]arpoon [A]ppend',
      },
      {
        '<leader>hc',
        function()
          require('harpoon'):list():clear()
        end,
        desc = '[H]arpoon [C]lear',
      },
      {
        '<leader>hn',
        function()
          require('harpoon'):list():next()
        end,
        desc = '[H]arpoon [N]ext',
      },
      {
        '<leader>hp',
        function()
          require('harpoon'):list():prev()
        end,
        desc = '[H]arpoon [P]rev',
      },
      {
        '<M-1>',
        function()
          require('harpoon'):list():select(1)
        end,
      },
      {
        '<M-2>',
        function()
          require('harpoon'):list():select(2)
        end,
      },
      {
        '<M-3>',
        function()
          require('harpoon'):list():select(3)
        end,
      },
      {
        '<M-4>',
        function()
          require('harpoon'):list():select(4)
        end,
      },
      {
        '<M-5>',
        function()
          require('harpoon'):list():select(5)
        end,
      },
      {
        '<M-6>',
        function()
          require('harpoon'):list():select(6)
        end,
      },
    },
    config = function()
      require('harpoon'):setup()
    end,
  },
  {
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
  },
  {
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
  },
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    -- Separated from telescope due to lazy loading reasons
    'debugloop/telescope-undo.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
    },
    keys = {
      {
        '<leader>su',
        '<cmd>Telescope undo<CR>',
        desc = '[S]earch [U]ndo history',
      },
    },
    opts = {
      extensions = { undo = {} },
    },
    config = function(_, opts)
      require('telescope').setup(opts)
      require('telescope').load_extension 'undo'
    end,
  },
}
