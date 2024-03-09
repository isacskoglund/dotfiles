vim.g.mapleader = " "

-- insert new line below without moving cursor or leaving normal mode
vim.keymap.set("n", "<leader>o", "o<Esc>k")
-- insert new line above without moving cursor or leaving normal mode
vim.keymap.set("n", "<leader>O", "O<Esc>j")

vim.wo.number = true
vim.wo.relativenumber = true
vim.api.nvim_set_hl(0, "LineNr", { fg = "#8591a6" })
