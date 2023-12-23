local dap = require 'dap'

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

--for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
--  if not dap.configurations[language] then
--    dap.configurations[language] = {
--      {
--        type = "pwa-node",
--        request = "launch",
--        name = "Launch file",
--        program = "${file}",
--        cwd = "${workspaceFolder}",
--      },
--      {
--        type = "pwa-node",
--        request = "attach",
--        name = "Attach",
--        processId = require("dap.utils").pick_process,
--        cwd = "${workspaceFolder}",
--      },
--    }
--  end
--end

--for _, adapter in ipairs { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" } do
--  dap.adapters[adapter] = {
--    type = "server",
--    host = "localhost",
--    port = "${port}",
--    executable = {
--      command = "node",
--      args = {
--        get_js_debug(),
--        "${port}",
--      },
--    },
--  }
--end

dap.configurations.javascript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file',
    -- program = '${workspaceFolder}/src/server.js',
    program = '${file}',
    cwd = '${workspaceFolder}',
    -- env = {
    --   MYSQL_HOSTNAME = 'localhost',
    --   MYSQL_USER = 'root',
    --   MYSQL_PASSWORD = 'password',
    -- },
  },
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch mocha test',
    -- program = '${workspaceFolder}/src/server.js',
    program = '${workspaceFolder}',
    runtimeExecutable = 'node',
    runtimeArgs = {
      './node_modules/mocha/bin/mocha',
    },
    cwd = '${workspaceFolder}',
    -- env = {
    --   MYSQL_HOSTNAME = 'localhost',
    --   MYSQL_USER = 'root',
    --   MYSQL_PASSWORD = 'password',
    -- },
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
    -- program = '${file}',
    program = '${workspaceFolder}/src/server.ts',
    -- env = {
    --   DB_USER = 'root',
    --   DB_PASSWORD = 'password',
    --   DB_HOST = 'localhost',
    --   JWT_SECRET = 'secret',
    --   DB_NAME = 'Trybesmith',
    --   DB_PORT = 3306,
    -- },
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
    -- program = '${file}',
    program = '${workspaceFolder}/src/tests/matches.integration.test.ts',
    -- env = {
    --   DB_USER = 'root',
    --   DB_PASSWORD = 'password',
    --   DB_HOST = 'localhost',
    --   JWT_SECRET = 'secret',
    --   DB_NAME = 'Trybesmith',
    --   DB_PORT = 3306,
    -- },
    cwd = '${workspaceFolder}',
  },
}

-- for _, language in ipairs { "typescript", "javascript" } do
--   dap.configurations[language] = {
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Launch file",
--       program = "${file}",
--       cwd = "${workspaceFolder}",
--     },
--     {
--       type = "pwa-node",
--       request = "attach",
--       name = "Attach",
--       processId = require("dap.utils").pick_process,
--       cwd = "${workspaceFolder}",
--     },
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Debug Jest Tests",
--       -- trace = true, -- include debugger info
--       runtimeExecutable = "node",
--       runtimeArgs = {
--         "./node_modules/jest/bin/jest.js",
--         "--runInBand",
--       },
--       rootPath = "${workspaceFolder}",
--       cwd = "${workspaceFolder}",
--       console = "integratedTerminal",
--       internalConsoleOptions = "neverOpen",
--     },
--     {
--       type = "pwa-chrome",
--       name = "Attach - Remote Debugging",
--       request = "attach",
--       program = "${file}",
--       cwd = vim.fn.getcwd(),
--       sourceMaps = true,
--       protocol = "inspector",
--       port = 9222,     -- Start Chrome google-chrome --remote-debugging-port=9222
--       webRoot = "${workspaceFolder}",
--     },
--     {
--       type = "pwa-chrome",
--       name = "Launch Chrome",
--       request = "launch",
--       url = "http://localhost:5173",     -- This is for Vite. Change it to the framework you use
--       webRoot = "${workspaceFolder}",
--       userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
--     },
--   }
-- end

--for _, language in ipairs { "typescriptreact", "javascriptreact" } do
--  dap.configurations[language] = {
--    {
--      type = "pwa-chrome",
--      name = "Attach - Remote Debugging",
--      request = "attach",
--      program = "${file}",
--      cwd = vim.fn.getcwd(),
--      sourceMaps = true,
--      protocol = "inspector",
--      port = 9222,     -- Start Chrome google-chrome --remote-debugging-port=9222
--      webRoot = "${workspaceFolder}",
--    },
--    {
--      type = "pwa-chrome",
--      name = "Launch Chrome",
--      request = "launch",
--      url = "http://localhost:5173",     -- This is for Vite. Change it to the framework you use
--      webRoot = "${workspaceFolder}",
--      userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
--    },
--  }
--end
--local exts = {
--  'javascript',
--  'typescript',
--  'javascriptreact',
--  'typescriptreact',
--  -- using pwa-chrome
--  'vue',
--  'svelte',
--}

--for _, ext in ipairs(exts) do
--  dap.configurations[ext] = {
--    {
--      type = 'pwa-node',
--      request = 'launch',
--      name = 'Launch Current File (pwa-node)',
--      cwd = vim.fn.getcwd(),
--      args = { '${file}' },
--      sourceMaps = true,
--      protocol = 'inspector',
--    },
--    {
--      type = 'pwa-node',
--      request = 'launch',
--      name = 'Launch Current File (pwa-node with ts-node)',
--      cwd = vim.fn.getcwd(),
--      runtimeArgs = { '--loader', 'ts-node/esm' },
--      runtimeExecutable = 'node',
--      args = { '${file}' },
--      sourceMaps = true,
--      protocol = 'inspector',
--      skipFiles = { '<node_internals>/**', 'node_modules/**' },
--      resolveSourceMapLocations = {
--        "${workspaceFolder}/**",
--        "!**/node_modules/**",
--      },
--    },
--    {
--      type = 'pwa-node',
--      request = 'launch',
--      name = 'Launch Current File (pwa-node with deno)',
--      cwd = vim.fn.getcwd(),
--      runtimeArgs = { 'run', '--inspect-brk', '--allow-all', '${file}' },
--      runtimeExecutable = 'deno',
--      attachSimplePort = 9229,
--    },
--    {
--      type = 'pwa-node',
--      request = 'launch',
--      name = 'Launch Test Current File (pwa-node with jest)',
--      cwd = vim.fn.getcwd(),
--      runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
--      runtimeExecutable = 'node',
--      args = { '${file}', '--coverage', 'false'},
--      rootPath = '${workspaceFolder}',
--      sourceMaps = true,
--      console = 'integratedTerminal',
--      internalConsoleOptions = 'neverOpen',
--      skipFiles = { '<node_internals>/**', 'node_modules/**' },
--    },
--    {
--      type = 'pwa-node',
--      request = 'launch',
--      name = 'Launch Test Current File (pwa-node with vitest)',
--      cwd = vim.fn.getcwd(),
--      program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
--      args = { '--inspect-brk', '--threads', 'false', 'run', '${file}' },
--      autoAttachChildProcesses = true,
--      smartStep = true,
--      console = 'integratedTerminal',
--      skipFiles = { '<node_internals>/**', 'node_modules/**' },
--    },
--    {
--      type = 'pwa-node',
--      request = 'launch',
--      name = 'Launch Test Current File (pwa-node with deno)',
--      cwd = vim.fn.getcwd(),
--      runtimeArgs = { 'test', '--inspect-brk', '--allow-all', '${file}' },
--      runtimeExecutable = 'deno',
--      attachSimplePort = 9229,
--    },
--    {
--      type = 'pwa-chrome',
--      request = 'attach',
--      name = 'Attach Program (pwa-chrome = { port: 9222 })',
--      program = '${file}',
--      cwd = vim.fn.getcwd(),
--      sourceMaps = true,
--      port = 9222,
--      webRoot = '${workspaceFolder}',
--    },
--    {
--      type = 'node2',
--      request = 'attach',
--      name = 'Attach Program (Node2)',
--      processId = require('dap.utils').pick_process,
--    },
--    {
--      type = 'node2',
--      request = 'attach',
--      name = 'Attach Program (Node2 with ts-node)',
--      cwd = vim.fn.getcwd(),
--      sourceMaps = true,
--      skipFiles = { '<node_internals>/**' },
--      port = 9229,
--    },
--    {
--      type = 'pwa-node',
--      request = 'attach',
--      name = 'Attach Program (pwa-node)',
--      cwd = vim.fn.getcwd(),
--      processId = require('dap.utils').pick_process,
--      skipFiles = { '<node_internals>/**' },
--    },
--  }
--end
