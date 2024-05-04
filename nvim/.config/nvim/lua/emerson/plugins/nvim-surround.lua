return {
  'kylechui/nvim-surround',
  keys = {
    { 'cs', mode = { 'n', 'v' } },
    { 'ys', mode = { 'n', 'v' } },
    { 'ds', mode = { 'n', 'v' } },
  },
  lazy = true,
  version = '*', -- Use for stability; omit to use `main` branch for the latest features
  config = true,
}
