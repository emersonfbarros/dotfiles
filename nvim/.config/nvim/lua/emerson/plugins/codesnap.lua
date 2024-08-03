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
    watermark = '',
    breadcrumbs_separator = '/',
    has_breadcrumbs = true,
    show_workspace = true,
    has_line_number = true,
    bg_x_padding = 35,
    bg_y_padding = 35,
  },
  build = 'make',
}
