return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
    local lualine = require 'lualine'

    local p = {
      rose = '#ebbcba',
      pine = '#31748f',
      base = '#191724',
      overlay = '#26233a',
      foam = '#9ccfd8',
      text = '#e0def4',
      muted = '#6e6a86',
      iris = '#c4a7e7',
      love = '#eb6f92',
      custom = '#2e2b42',
    }

    local my_theme = {
      normal = {
        a = { bg = p.rose, fg = p.base, gui = 'bold' },
        b = { bg = p.overlay, fg = p.rose },
        c = { bg = p.custom, fg = p.text },
      },
      insert = {
        a = { bg = p.foam, fg = p.base, gui = 'bold' },
        b = { bg = p.overlay, fg = p.foam },
        c = { bg = p.custom, fg = p.text },
      },
      visual = {
        a = { bg = p.iris, fg = p.base, gui = 'bold' },
        b = { bg = p.overlay, fg = p.iris },
        c = { bg = p.custom, fg = p.text },
      },
      replace = {
        a = { bg = p.pine, fg = p.base, gui = 'bold' },
        b = { bg = p.overlay, fg = p.pine },
        c = { bg = p.custom, fg = p.text },
      },
      command = {
        a = { bg = p.love, fg = p.base, gui = 'bold' },
        b = { bg = p.overlay, fg = p.love },
        c = { bg = p.custom, fg = p.text },
      },
      inactive = {
        a = { bg = p.base, fg = p.muted, gui = 'bold' },
        b = { bg = p.base, fg = p.muted },
        c = { bg = p.custom, fg = p.muted },
      },
    }

    lualine.setup {
      options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
        theme = my_theme,
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
        lualine_z = {
          'location',
          function()
            return ' '
          end,
        },
      },
    }
  end,
}
