return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',

    -- Adapters
    'nvim-neotest/neotest-go',
    'nvim-neotest/neotest-jest',
  },
  keys = {
    {
      '<leader>ta',
      function()
        require('neotest').run.attach()
      end,
      desc = '[T]est [A]ttach',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = '[T]est [F]ile',
    },
    {
      '<leader>tA',
      function()
        require('neotest').run.run(vim.uv.cwd())
      end,
      desc = '[T]est [A]ll Files',
    },
    {
      '<leader>tS',
      function()
        require('neotest').run.run { suite = true }
      end,
      desc = '[T]est [S]uite',
    },
    {
      '<leader>tn',
      function()
        require('neotest').run.run()
      end,
      desc = '[T]est [N]earest',
    },
    {
      '<leader>tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = '[T]est [L]ast',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = '[T]oggle [S]ummary',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open { enter = true, auto_close = true }
      end,
      desc = '[T]est [O]utput',
    },
    {
      '<leader>tp',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = '[T]oggle [P]anel',
    },
    {
      '<leader>tt',
      function()
        require('neotest').run.stop()
      end,
      desc = '[T]est [T]erminate',
    },
    {
      '<leader>td',
      function()
        require('neotest').summary.close()
        require('neotest').output_panel.close()

        if vim.api.nvim_get_option_value('filetype', {}) == 'go' then
          require('dap-go').debug_test()
        else
          require('neotest').run.run { suite = false, strategy = 'dap' }
        end
      end,
      desc = '[T]est [D]ebug',
    },
  },
  config = function()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

    ---@diagnostic disable-next-line: missing-fields
    require('neotest').setup {
      adapters = {
        require 'rustaceanvim.neotest',

        require 'neotest-go' {
          experimental = {
            test_table = true,
          },
        },

        require 'neotest-jest' {
          jestCommand = 'npm test --',
          jestConfigFile = 'jest.config.js',
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        },
      },
      discovery = {
        -- Drastically improve performance in ginormous projects by
        -- only AST-parsing the currently opened buffer.
        enabled = false,
        -- Number of workers to parse files concurrently.
        -- A value of 0 automatically assigns number based on CPU.
        -- Set to 1 if experiencing lag.
        concurrent = 0,
      },
      running = {
        -- Run tests concurrently when an adapter provides multiple commands to run.
        concurrent = true,
      },
      summary = {
        -- Enable/disable animation of icons.
        animated = true,
      },
    }
  end,
}
