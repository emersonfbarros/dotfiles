return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  event = 'VeryLazy',
  config = function()
    local servers = vim.tbl_keys(require 'emerson.plugins.tools.servers')
    local linters = require 'emerson.plugins.tools.linters'
    local formatters = require 'emerson.plugins.tools.formatters'
    local daps = require 'emerson.plugins.tools.daps'

    local tools_to_install = {}
    -- Concatenates the tables
    for _, server in ipairs(servers) do
      table.insert(tools_to_install, server)
    end
    for _, linter in ipairs(linters) do
      table.insert(tools_to_install, linter)
    end
    for _, formatter in ipairs(formatters) do
      table.insert(tools_to_install, formatter)
    end
    for _, dap in ipairs(daps) do
      table.insert(tools_to_install, dap)
    end

    require('mason-tool-installer').setup {
      ensure_installed = tools_to_install,
    }
  end,
}
