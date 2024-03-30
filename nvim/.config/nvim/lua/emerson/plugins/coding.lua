return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'zbirenbaum/copilot-cmp',
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = 'make install_jsregexp',
        dependencies = {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      require('copilot_cmp').setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered {
            border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
            winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
          },
          documentation = cmp.config.window.bordered {
            border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
          },
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'copilot' },
          { name = 'luasnip' }, -- snippets
          { name = 'buffer' }, -- text within current buffer
          { name = 'path' }, -- file system paths
          { name = 'crates' }, -- rust crates
        },
      }
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = function()
      local autopairs = require 'nvim-autopairs'

      autopairs.setup {
        check_ts = true, -- enable treesitter
        ts_config = {
          lua = { 'string' }, -- don't add pairs in lua string treesitter nodes
          javascript = { 'template_string' }, -- don't add pairs in javscript template_string treesitter nodes
          java = false, -- don't check treesitter on java
        },
      }

      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'numToStr/Comment.nvim',
    keys = { { 'gc', mode = { 'n', 'v' } }, { 'gcc', mode = { 'n', 'v' } }, { 'gbc', mode = { 'n', 'v' } } },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = {},
    },
    config = function()
      local comment = require 'Comment'

      local ts_context_commentstring = require 'ts_context_commentstring.integrations.comment_nvim'

      comment.setup {
        ignore = '^$',
        pre_hook = ts_context_commentstring.create_pre_hook(),
      }
    end,
  },
  {
    'kylechui/nvim-surround',
    keys = { { 'cs', mode = { 'n', 'v' } }, { 'ys', mode = { 'n', 'v' } }, { 'ds', mode = { 'n', 'v' } } },
    lazy = true,
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    config = true,
  },
  {
    'stevearc/conform.nvim',
    lazy = true,
    cmd = { 'ConformInfo' },
    dependencies = 'WhoIsSethDaniel/mason-tool-installer.nvim',
    keys = {
      {
        '<leader>cp',
        mode = { 'n', 'v' },
        function()
          require('conform').format {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          }
        end,
        desc = '[C]ode [P]retty',
      },
    },
    config = function()
      local ensure_installed_formatters = {
        'prettier', -- js/ts formatter
        'black', -- python formatter
        'isort', -- python imports organizer
        'stylua', -- lua formatter
        'csharpier', -- C# formatter
        'black', -- python formatter
        'shellcheck', -- shell linter and formatter
        'buf', -- to work with protobuff
      }

      require('mason-tool-installer').setup { ensure_installed = ensure_installed_formatters }

      local conform = require 'conform'

      conform.setup {
        formatters_by_ft = {
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          javascriptreact = { 'prettier' },
          typescriptreact = { 'prettier' },
          css = { 'prettier' },
          html = { 'prettier' },
          json = { 'prettier' },
          yaml = { 'prettier' },
          markdown = { 'prettier' },
          graphql = { 'prettier' },
          lua = { 'stylua' },
          python = { 'black' },
          sh = { 'shellcheck' },
          proto = { 'buf' },
        },
        format_on_save = nil,
      }
    end,
  },
  {
    'mfussenegger/nvim-lint',
    lazy = true,
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = 'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      local ensure_installed_linters = {
        'eslint_d', -- js/ts linter
        'flake8', -- python linter
        'golangci-lint',
        'buf', -- to work with protobuff

      }

      require('mason-tool-installer').setup { ensure_installed = ensure_installed_linters }

      local lint = require 'lint'

      lint.linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        python = { 'flake8' },
        proto = { 'buf_lint' },
        zsh = { 'zsh' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set('n', '<leader>cl', function()
        lint.try_lint()
      end, { desc = '[C]ode [L]int' })
    end,
  },
}
