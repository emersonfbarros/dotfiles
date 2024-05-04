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
  cmd = 'Neotest',
  keys = {
    {'<leader>tt', '<cmd>Neotest summary toggle<CR>', desc = 'Neo[T]est [T]oggle'},
    {'<leader>tp', '<cmd>Neotest output-panel<CR>', desc = 'Neo[T]est [P]anel'},
    {'<leader>tf', '<cmd>Neotest run<CR>', desc = 'Neo[T]est [f]unction'},
    {'<leader>tF', '<cmd>Neotest run file<CR>', desc = 'Neo[T]est [F]ile'},
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
    require('neotest').setup {
      adapters = {
        require 'neotest-go',
        require 'rustaceanvim.neotest',
        require 'neotest-jest' {
          jestCommand = 'npm test --',
          jestConfigFile = 'jest.config.js',
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        },
      },
    }
  end,
}
