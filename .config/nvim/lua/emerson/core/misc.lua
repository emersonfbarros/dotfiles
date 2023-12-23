-- [[ Initializes nvim-tree if neovim open a directory ]]
vim.cmd [[
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | NvimTreeToggle | wincmd p | endif
]]

local function augroup(name)
  return vim.api.nvim_create_augroup('nvim_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = augroup 'highlight_yank',
  pattern = '*',
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = augroup 'GoFormat',
})

-- Check if we need to reload the file when it changed
-- vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
--   group = augroup 'checktime',
--   command = 'checktime',
-- })

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup 'resize_splits',
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- [[ Borders around windows ]]
local _border = 'single'

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = _border,
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = _border,
})

vim.diagnostic.config {
  float = { border = _border },
}
