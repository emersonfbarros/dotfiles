return {
  'RRethy/vim-illuminate',
  event = { 'BufReadPost', 'BufNewFile' },
  lazy = true,
  config = function()
    require('illuminate').configure {
      delay = 200,
      large_file_cutoff = 2000,
      providers = {
        'lsp',
        'treesitter',
      },
      filetypes_denylist = {
        'dirvish',
        'fugitive',
        'alpha',
        'NvimTree',
        'lazy',
        'neogitstatus',
        'Trouble',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'DressingSelect',
        'TelescopePrompt',
      },
      large_file_overrides = {
        providers = { 'lsp' },
      },
    }
  end,
}
