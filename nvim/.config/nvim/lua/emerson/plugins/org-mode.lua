return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  dependencies = {
    {
      'nvim-orgmode/org-bullets.nvim',
      opts = {},
    },
  },
  ft = { 'org' },
  opts = {
    org_agenda_files = '~/orgfiles/**/*',
    org_default_notes_file = '~/orgfiles/refile.org',
    mappings = {
      org = {
        org_toggle_checkbox = '<M-Space>',
      },
    },
  },
}
