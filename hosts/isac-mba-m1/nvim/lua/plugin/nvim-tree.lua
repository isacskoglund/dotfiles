-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("nvim-tree").setup()

-- Toggle nvim tree without focusing on it.
function toggle_nvim_tree_without_focus()
  local view = require'nvim-tree.view'
  if view.is_visible() then
    vim.api.nvim_command('NvimTreeClose')
  else
    vim.api.nvim_command('NvimTreeOpen')
    vim.api.nvim_command('wincmd p') -- Switch back to the previous window
  end
end

-- Toggle focus on nvim tree. If tree is closed, open it. Never close it.
function toggle_nvim_tree_focus()
    local view = require('nvim-tree.view')
    local api = vim.api
    if view.is_visible() and view.get_winnr() == api.nvim_get_current_win() then
        -- NvimTree is focused, so switch back to the previous window
        api.nvim_command('wincmd p')
    else
        -- NvimTree is not focused, so focus on it
        api.nvim_command('NvimTreeFocus')
    end
end

function toggle_nvim_tree_folder()
    local node = require('nvim-tree.lib').get_node_at_cursor()
    if node.type == 'directory' then
      require('nvim-tree.api').node.open.edit()
    end
  end


function close_nvim_tree_folder_and_focus_on_parent()
    local lib = require('nvim-tree.lib')
    local api = require('nvim-tree.api')
    local parent = lib.get_node_at_cursor().parent
    if parent then
        api.node.open.edit(parent)
        api.tree.find_file(parent.absolute_path)
    end
end
  
-- Key mappings
vim.api.nvim_set_keymap('n', '<leader>et', ':lua toggle_nvim_tree_without_focus()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ef', ':lua toggle_nvim_tree_focus()<CR>', { noremap = true, silent = true })
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "NvimTree",
        callback = function()
            -- Toggle folder with 'l'
            vim.api.nvim_buf_set_keymap(0, 'n', 'l', ':lua toggle_nvim_tree_folder()<CR>', { noremap = true, silent = true })
            
            -- Close current folder and select parent with 'h'
            vim.api.nvim_buf_set_keymap(0, 'n', 'h', ':lua close_nvim_tree_folder_and_focus_on_parent()<CR>', { noremap = true, silent = true })

            -- 
        end
    }
)


