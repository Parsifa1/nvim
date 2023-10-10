-- define common options
local opts = {
    noremap = true, -- non-recursive
    silent = true,  -- do not show message
}

-- vim.g.mapleader = "<Space>"


vim.keymap.set('n', '==', 'gqq', opts)
vim.keymap.set('v', '=', 'gq', opts)


if vim.g.vscode then
else
    -- Resize with arrows
    -- delta: 2 lines
    local api = require('nvim-tree.api')
    vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
    vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
    vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
    vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)
    vim.keymap.set('n', '<C-B>', ':NvimTreeToggle<CR>', opts)
end
