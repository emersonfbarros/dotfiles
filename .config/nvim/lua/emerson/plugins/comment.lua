return {
  'numToStr/Comment.nvim',
  -- event = { 'BufReadPre', 'BufNewFile' },
  keys = { { 'gc', mode = { 'n', 'v' } }, { 'gcc', mode = { 'n', 'v' } }, { 'gbc', mode = { 'n', 'v' } } },
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {},
  },
  config = function()
    -- import comment plugin safely
    local comment = require 'Comment'

    local ts_context_commentstring = require 'ts_context_commentstring.integrations.comment_nvim'

    -- enable comment
    comment.setup {
      ignore = '^$',
      -- for commenting tsx and jsx files
      pre_hook = ts_context_commentstring.create_pre_hook(),
    }
  end,
}
