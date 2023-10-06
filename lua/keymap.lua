-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}
vim.g.mapleader = " "
-----------------
-- Normal mode --
-----------------

vim.keymap.set('i', 'jj', '<ESC><CR>')

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)
vim.keymap.set('n', '<A-w>', ':NvimTreeToggle<CR>', opts)
-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
