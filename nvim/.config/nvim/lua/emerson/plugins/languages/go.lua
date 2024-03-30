return {
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    ft = { 'go', 'gomod' },
    config = function()
      require('go').setup()

      require('which-key').register {
        ['<leader>G'] = {
          name = '+[G]o',
          a = { '<cmd>GoAddTag<CR>', '[A]dd Tags' },
          f = { '<cmd>GoFillStruct<CR>', '[F]ill Struct' },
          e = { '<cmd>GoIfErr<CR>', 'If[E]rr' },
          t = { '<cmd>Neotest run', '[T]est Func' },
          T = { '<cmd>Neotest run', '[T]est File' },
        },
      }

      local format_sync_grp = vim.api.nvim_create_augroup('go', {})
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
          require('go.format').goimports()
        end,
        group = format_sync_grp,
      })

      vim.api.nvim_buf_create_user_command(0, 'GoDebugTest', function(_)
        require('dap-go').debug_test()
      end, { desc = 'Start debugging Go Test' })
    end,
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    'edolphin-ydf/goimpl.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      { '<leader>Gi', '<cmd>lua require"telescope".extensions.goimpl.goimpl{}<CR>', desc = '[G]o [I]mplement' },
    },
    config = function()
      require('telescope').load_extension 'goimpl'
    end,
  },
}
