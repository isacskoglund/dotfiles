vim.g.mapleader = " "
vim.diagnostic.config(
	{
		update_in_insert = true,
		virtual_text = {
			spacing = 10
		}
	}
)


vim.o.signcolumn = "yes:2"
vim.o.tabstop = 4
-- vim.o.expandtab = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.wo.number = true
vim.wo.relativenumber = true
vim.api.nvim_set_hl(0, "LineNr", { fg = "#8591a6" })
vim.api.nvim_set_option("clipboard", "unnamedplus")
