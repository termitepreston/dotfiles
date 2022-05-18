-- vim set jk to escape for insert mode.
vim.keymap.set("i", "jk", "<Esc>")

-- set Esc to enter normal mode in terminal.
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- set tabsize to 4.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
