return {
  'mfussenegger/nvim-dap',
  dependencies = {
    { 'rcarriga/nvim-dap-ui', dependencies = 'nvim-neotest/nvim-nio' },
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  lazy = true,
  enabled = true,
  keys = {
    { '<leader>db', "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = '[D]ebug: Toggle [B]reakpoint' },
    { '<leader>du', "<cmd>lua require('dapui').toggle()<CR>", desc = '[D]ebug: Toggle UI' },
    { '<leader>ds', '<cmd>lua require(dap).continue()<CR>', desc = '[D]ebug: [S]tart/Continue' },
    { '<leader>di', '<cmd>lua require(dap).step_into()<CR>', desc = '[D]ebug: Step [I]nto' },
    { '<leader>do', '<cmd>lua require(dap).step_over()<CR>', desc = '[D]ebug: Step [O]ver' },
    { '<leader>de', '<cmd>lua require(dap).step_out()<CR>', desc = '[D]ebug: Step Out/[E]xit' },
  },
  config = function()
    local dap = require 'dap'

    local dapui = require 'dapui'
    dapui.setup {}

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['daui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    if filetype == 'javascript' or filetype == 'typescript' then
      -- js/ts hell
      local function get_js_debug()
        local install_path = require('mason-registry').get_package('js-debug-adapter'):get_install_path()
        return install_path .. '/js-debug/src/dapDebugServer.js'
      end
      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            get_js_debug(),
            '${port}',
          },
        },
      }
      dap.configurations.javascript = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch mocha test',
          program = '${workspaceFolder}',
          runtimeExecutable = 'node',
          runtimeArgs = {
            './node_modules/mocha/bin/mocha',
          },
          cwd = '${workspaceFolder}',
        },
      }
      dap.configurations.typescript = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file with ts-node',
          sourceMaps = true,
          resolveSourceMapLocations = {
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
          protocol = 'inspector',
          runtimeExecutable = 'node',
          runtimeArgs = {
            '-r',
            'ts-node/register',
          },
          program = '${workspaceFolder}/src/server.ts',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch mocha test with ts-node',
          sourceMaps = true,
          resolveSourceMapLocations = {
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
          protocol = 'inspector',
          runtimeExecutable = 'node',
          runtimeArgs = {
            '-r',
            'ts-node/register',
            './node_modules/mocha/bin/mocha',
          },
          program = '${workspaceFolder}/src/tests/matches.integration.test.ts',
          cwd = '${workspaceFolder}',
        },
      }
    elseif filetype == 'python' then
      local path = require('mason-registry').get_package('debugpy'):get_install_path()
      require('dap-python').setup(path .. '/venv/bin/python')
    elseif filetype == 'go' then
      require('dap-go').setup()
    end
  end,
}
