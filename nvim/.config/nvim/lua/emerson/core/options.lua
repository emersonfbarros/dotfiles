-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
-- vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Don't show mode since we have status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- ColorColumn
vim.o.colorcolumn = '80'

-- Enabel cursor line
vim.o.cursorline = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- my tabstop and shiftwidth
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.shiftround = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- My scrolloff
vim.o.scrolloff = 8

-- Netrw options
-- vim.g.netrw_banner = 0
-- vim.g.netrw_browse_split=4
-- vim.g.netrw_altv = 1
-- vim.g.netrw_liststyle=3

-- split windows
vim.o.splitright = true -- split vertical window to the right
vim.o.splitbelow = true -- split horizontal window to the bottom
