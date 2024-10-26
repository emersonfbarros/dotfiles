return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
    'leoluz/nvim-dap-go',
  },
  lazy = true,
  enabled = true,
  keys = {
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'toggle [D]ebug [b]reakpoint',
    },
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = '[D]ebug [c]ontinue (start here)',
    },
    {
      '<leader>dC',
      function()
        require('dap').run_to_cursor()
      end,
      desc = '[D]ebug [C]ursor',
    },
    {
      '<leader>do',
      function()
        require('dap').step_over()
      end,
      desc = '[D]ebug step [o]ver',
    },
    {
      '<leader>dO',
      function()
        require('dap').step_out()
      end,
      desc = '[D]ebug step [O]ut',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = '[D]ebug [i]nto',
    },
    {
      '<leader>dR',
      function()
        require('dap').clear_breakpoints()
      end,
      desc = '[D]ebug [R]emove breakpoints',
    },
    {
      '<leader>dt',
      function()
        require('dap').terminate()
      end,
      desc = '[D]ebug [t]erminate',
    },
    {
      '<leader>dw',
      function()
        require('dap.ui.widgets').hover()
      end,
      desc = '[D]ebug [w]idgets',
    },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = '[D]ebug: Toggle [U]I',
    },
  },
  config = function()
    local dap = require 'dap'
    local ui = require 'dapui'

    require('nvim-dap-virtual-text').setup {}
    require('dapui').setup()
    -- setup dap config by .vscode/launch.json file
    require('dap.ext.vscode').load_launchjs()

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end

    -- vim.api.nvim_get_option_value('filetype')
    local filetype = vim.api.nvim_get_option_value('filetype', {})
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
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch jest test with ts-jest',
          sourceMaps = true,
          resolveSourceMapLocations = {
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
          protocol = 'inspector',
          runtimeExecutable = 'node',
          runtimeArgs = {
            '-r',
            'ts-jest',
            './node_modules/jest/bin/jest.js',
          },
          cwd = '${workspaceFolder}',
        },
      }
    elseif filetype == 'go' then
      require('dap-go').setup()
    end
  end,
}
