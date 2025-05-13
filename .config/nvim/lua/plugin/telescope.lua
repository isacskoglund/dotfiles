local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		vimgrep_arguments = {
		  'rg',
		  '--color=never',
		  '--no-heading',
		  '--with-filename',
		  '--line-number',
		  '--column',
		  '--smart-case'
		},
		mappings = {
			i = { -- Insert mode mappings
				["<C-j>"] = actions.move_selection_next, -- Move to next result
				["<C-k>"] = actions.move_selection_previous, -- Move to previous result
			},
		},
		find_command = {'fd', '--type', 'f', '--hidden', '--follow'}
	}
})

vim.keymap.set(
	"n",
	"<leader>ff",
	function()
		builtin.find_files({ no_ignore = true, hidden = true })
	end,
	{
		noremap = true,
		silent = true,
	}
)
vim.keymap.set(
	"n",
	"<leader>fa",
	function()
		builtin.find_files({ no_ignore = true, hidden = true, cwd = "~"})
	end,
	{
		noremap = true,
		silent = true,
	}
)
vim.keymap.set(
	"n",
	"<leader>fg",
	builtin.live_grep,
	{
		noremap = true,
		silent = true,
	}
)
