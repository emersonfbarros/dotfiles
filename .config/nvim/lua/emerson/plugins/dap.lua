return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },
    'mfussenegger/nvim-dap-python', -- for easy debugpy setup
  },
  lazy = true,
  enabled = true,
  keys = {
    vim.keymap.set('n', '<leader>db', "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = 'Toggle Breakpoint' }),
    vim.keymap.set('n', '<leader>dU', "<cmd>lua require('dapui').toggle()<cr>", { desc = 'Toggle DAP UI' }),
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    dapui.setup {}

    -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
    --vim.keymap.set("n", "<leader>dU", "<cmd>lua require('dapui').toggle()<cr>", { desc = 'Toggle UI' })
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    if filetype == 'javascript' or filetype == 'typescript' then
      require 'emerson.utils.jstsdebugger'
    elseif filetype == 'python' then
      local path = require('mason-registry').get_package('debugpy'):get_install_path()
      require('dap-python').setup(path .. '/venv/bin/python')
      -- require 'core.utils.python_debugger'
    end
  end,
}
