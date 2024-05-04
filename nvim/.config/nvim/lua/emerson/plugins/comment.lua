return {
  'numToStr/Comment.nvim',
  keys = {
    { 'gc', mode = { 'n', 'v' } },
    { 'gcc', mode = { 'n', 'v' } },
    { 'gbc', mode = { 'n', 'v' } },
  },
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {},
  },
  config = function()
    local comment = require 'Comment'

    local ts_context_commentstring = require 'ts_context_commentstring.integrations.comment_nvim'

    comment.setup {
      ignore = '^$',
      pre_hook = ts_context_commentstring.create_pre_hook(),
    }
  end,
}
