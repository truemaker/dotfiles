-- Useful stuff
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.rnu = true
vim.o.nu = true

vim.o.smartindent = true

vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = false

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.scrolloff = 999
vim.o.signcolumn = "yes"

vim.o.updatetime = 50

vim.o.termguicolors = true

vim.o.cursorline = true
-- vim.o.complete=nil

vim.o.confirm = true

vim.api.nvim_command("filetype plugin indent on")
vim.g.vimtex_view_method = 'zathura'

-- vim.o.nocompatible = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown", "vimwiki" },
  command = "setlocal spell"
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md",
  command = "set filetype=markdown"
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.txt",
  command = "set filetype=text"
})

vim.api.nvim_command("syntax on")
