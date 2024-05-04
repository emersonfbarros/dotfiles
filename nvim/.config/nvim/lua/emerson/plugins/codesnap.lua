return {
  'mistricky/codesnap.nvim',
  cmd = 'CodeSnap',
  keys = {
    {
      '<leader>ci',
      mode = 'x',
      ":'<,'>CodeSnap<CR>",
      desc = '[C]ode [I]mage',
    },
  },
  opts = {
    mac_window_bar = false,
    title = 'CodeSnap.nvim',
    code_font_family = 'JetBrainsMono NF',
    bg_theme = 'default',
    bg_color = '#191724',
    breadcrumbs_separator = '/',
    has_breadcrumbs = false,
  },
  build = 'make',
}
