return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'AndreM222/copilot-lualine',
  },
  opts = {
    options = {
      icons_enabled = true,
      component_separators = ' ▎',
      section_separators = '',
      globalstatus = true,
      theme = function()
        local custom_rose_pine_theme = require 'lualine.themes.rose-pine'

        local modes = { 'normal', 'insert', 'visual', 'replace', 'command', 'inactive' }
        for _, mode in ipairs(modes) do
          custom_rose_pine_theme[mode].c.bg = '#1f1d2e'
        end

        return custom_rose_pine_theme
      end,
    },
    sections = {
      lualine_a = {
        {
          function()
            return ''
          end,
          separator = '',
        },
        'mode',
      },
      lualine_c = {
        {
          'filename',
          path = 1,
        },
      },
      lualine_x = { 'copilot', 'encoding', 'fileformat', 'filetype' },
    },
  },
}
