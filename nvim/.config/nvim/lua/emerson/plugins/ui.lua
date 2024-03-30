return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { 'n', 'v' },
        ['g'] = { name = '+goto' },
        ['gs'] = { name = '+surround' },
        [']'] = { name = '+next' },
        ['['] = { name = '+prev' },
        ['<leader>c'] = { name = '+[C]ode' },
        ['<leader>d'] = { name = '+[D]ebug' },
        ['<leader>e'] = { name = '+[E]xplorer' },
        ['<leader>f'] = { name = '+[F]ind' },
        ['<leader>g'] = { name = '+[G]it' },
        ['<leader>gh'] = { name = '+[H]unks' },
        ['<leader>h'] = { name = '+[H]arpoon' },
        ['<leader>s'] = { name = '+[S]earch' },
      },
    },
    config = function(_, opts)
      local wk = require 'which-key'
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = {
        char = '▏',
        tab_char = '▏',
        highlight = 'IndentBlanklineChar',
      },
      whitespace = {
        highlight = 'IndentBlanklineSpaceChar',
      },
      scope = {
        char = '▏',
        show_end = false,
        show_start = false,
        include = {
          node_type = {
            ['*'] = { '*' },
          },
        },
        enabled = true,
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
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      'AndreM222/copilot-lualine',
    },
    config = function()
      local lualine = require 'lualine'

      local p = {
        rose = '#ebbcba',
        pine = '#31748f',
        base = '#191724',
        overlay = '#26233a',
        foam = '#9ccfd8',
        text = '#e0def4',
        muted = '#6e6a86',
        iris = '#c4a7e7',
        love = '#eb6f92',
        custom = '#1f1d2e',
      }

      local my_theme = {
        normal = {
          a = { bg = p.rose, fg = p.base, gui = 'bold' },
          b = { bg = p.overlay, fg = p.rose },
          c = { bg = p.custom, fg = p.text },
        },
        insert = {
          a = { bg = p.foam, fg = p.base, gui = 'bold' },
          b = { bg = p.overlay, fg = p.foam },
          c = { bg = p.custom, fg = p.text },
        },
        visual = {
          a = { bg = p.iris, fg = p.base, gui = 'bold' },
          b = { bg = p.overlay, fg = p.iris },
          c = { bg = p.custom, fg = p.text },
        },
        replace = {
          a = { bg = p.pine, fg = p.base, gui = 'bold' },
          b = { bg = p.overlay, fg = p.pine },
          c = { bg = p.custom, fg = p.text },
        },
        command = {
          a = { bg = p.love, fg = p.base, gui = 'bold' },
          b = { bg = p.overlay, fg = p.love },
          c = { bg = p.custom, fg = p.text },
        },
        inactive = {
          a = { bg = p.base, fg = p.muted, gui = 'bold' },
          b = { bg = p.base, fg = p.muted },
          c = { bg = p.custom, fg = p.muted },
        },
      }

      lualine.setup {
        options = {
          icons_enabled = true,
          component_separators = '|',
          section_separators = '',
          globalstatus = true,
          theme = my_theme,
        },
        sections = {
          lualine_c = {
            {
              'filename',
              path = 1,
            },
          },
          lualine_x = { 'copilot', 'encoding', 'fileformat', 'filetype' },
          lualine_z = {
            'location',
            function()
              return ' '
            end,
          },
        },
      }
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },
}
