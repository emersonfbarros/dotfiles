return {
  dockerls = {},
  docker_compose_language_service = {},
  bashls = {},
  pyright = require 'emerson.utils.python',
  tsserver = {},
  jsonls = {},
  gopls = {
    analyses = {
      unusedparams = true,
    },
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true,
    },
    staticcheck = true,
    semanticTokens = true,
  },
  rust_analyzer = {},
  golangci_lint_ls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}
