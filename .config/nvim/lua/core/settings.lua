vim.g.mapleader = " "

-- insert new line below without moving cursor or leaving normal mode
vim.keymap.set("n", "<leader>o", "o<Esc>k")
-- insert new line above without moving cursor or leaving normal mode
vim.keymap.set("n", "<leader>O", "O<Esc>j")

vim.o.signcolumn = "yes:2"
vim.o.tabstop = 4
vim.o.expandtab = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.wo.number = true
vim.wo.relativenumber = true
vim.api.nvim_set_hl(0, "LineNr", { fg = "#8591a6" })
