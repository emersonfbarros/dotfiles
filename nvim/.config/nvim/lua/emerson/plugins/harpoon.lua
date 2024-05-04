return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>hl',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = '[H]arpoon [L]ist',
    },
    {
      '<leader>ha',
      function()
        require('harpoon'):list():add()
      end,
      desc = '[H]arpoon [A]ppend',
    },
    {
      '<leader>hc',
      function()
        require('harpoon'):list():clear()
      end,
      desc = '[H]arpoon [C]lear',
    },
    {
      '<leader>hn',
      function()
        require('harpoon'):list():next()
      end,
      desc = '[H]arpoon [N]ext',
    },
    {
      '<leader>hp',
      function()
        require('harpoon'):list():prev()
      end,
      desc = '[H]arpoon [P]rev',
    },
    {
      '<M-1>',
      function()
        require('harpoon'):list():select(1)
      end,
    },
    {
      '<M-2>',
      function()
        require('harpoon'):list():select(2)
      end,
    },
    {
      '<M-3>',
      function()
        require('harpoon'):list():select(3)
      end,
    },
    {
      '<M-4>',
      function()
        require('harpoon'):list():select(4)
      end,
    },
    {
      '<M-5>',
      function()
        require('harpoon'):list():select(5)
      end,
    },
    {
      '<M-6>',
      function()
        require('harpoon'):list():select(6)
      end,
    },
  },
  config = function()
    require('harpoon'):setup()
  end,
}
