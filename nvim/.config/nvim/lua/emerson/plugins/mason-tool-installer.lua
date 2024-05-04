return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  event = 'VeryLazy',
  config = function()
    local linters = {
      'eslint_d', -- js/ts linter
      'flake8', -- python linter
      'golangci-lint',
      'buf', -- to work with protobuff, both linter and formatter
    }

    local formatters = {
      'prettier', -- js/ts formatter
      'black', -- python formatter
      'isort', -- python imports organizer
      'stylua', -- lua formatter
      'csharpier', -- C# formatter
      'black', -- python formatter
      'shellcheck', -- shell linter and formatter
    }

    local daps = {
      'js-debug-adapter',
      'debugpy', --python debuger
      'delve', -- Go debugger
      'codelldb', -- C, C++, Zig, Rust debugger
    }

    local tools_to_install = {}
    -- Concatenates the tables
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
      ensure_installed = tools_to_install
    }
  end,
}
