-- Move between panes using Ctrl + h, j, k, l
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Disable default ways of creating splits
vim.keymap.set('n', '<C-w>v', '')
vim.keymap.set('n', '<C-w>s', '')

-- Create new splits using Ctrl w + h, j, k, l
vim.keymap.set('n', '<C-w>h', ':vsplit<CR>', { noremap = true, silent = true }) -- New pane on the left
vim.keymap.set('n', '<C-w>j', ':split<CR><C-w>j', { noremap = true, silent = true })  -- New pane below
vim.keymap.set('n', '<C-w>k', ':split<CR>', { noremap = true, silent = true })  -- New pane above
vim.keymap.set('n', '<C-w>l', ':vsplit<CR><C-w>l', { noremap = true, silent = true }) -- New pane on the right

-- Navigate autocompletion in commands with Ctrl j, k
vim.keymap.set('c', '<C-j>', '<C-n>', { noremap = true, silent = true })
vim.keymap.set('c', '<C-k>', '<C-p>', { noremap = true, silent = true })

-- Cut row with xx
vim.keymap.set('n', 'xx', 'Vx', { noremap = true, silent = true})

-- Do not overwrite the copy buffer when deleting.
vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true})
vim.keymap.set('n', 'D', '"_D', { noremap = true, silent = true})
vim.keymap.set('v', 'd', '"_d', { noremap = true, silent = true})
vim.keymap.set('n', 'dd', '"_dd', { noremap = true, silent = true})

-- Other
vim.keymap.set('n', '<leader>y', '"+y', { noremap = true, silent = true})
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true})
vim.keymap.set('n', '<C-q>', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cl', 'gcc', { remap = true, silent = true })
vim.keymap.set('v', '<leader>cl', 'gc', { remap = true, silent = true })

-- insert new line below without moving cursor or leaving normal mode
vim.keymap.set("n", "<leader>o", "o<Esc>k")
-- insert new line above without moving cursor or leaving normal mode
vim.keymap.set("n", "<leader>O", "O<Esc>j")





