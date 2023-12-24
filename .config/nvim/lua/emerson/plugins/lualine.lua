return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      icons_enabled = true,
      component_separators = '|',
      section_separators = '',
      globalstatus = true,
      theme = 'rose-pine',
    },
    sections = {
      lualine_c = {
        {
          'filename',
          path = 1,
          color = { bg = '#2e2b42' },
        },
      },
      lualine_z = {
        'location',
        function()
          return ' '
        end,
      },
    },
  },
}
