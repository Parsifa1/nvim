vim.g.mapleader = '<Space>'
-- define common options
local set = vim.keymap.set
local opts = {
    noremap = true, -- non-recursive
    silent = true,  -- do not show message
}

-- vim.g.mapleader = "<Space>"


set('n', '==', 'gqq', opts)
set('v', '=', 'gq', opts)
--翻页
set('n', '<C-u>', '9k', opts)
set('n', '<C-d>', '9j', opts)
--窗口跳转
set('n', '<A-h>', '<C-w>h', opts)
set('n', '<A-j>', '<C-w>j', opts)
set('n', '<A-k>', '<C-w>k', opts)
set('n', '<A-l>', '<C-w>l', opts)
--分屏
set('n', 'zv', ':vsp<CR>', opts)
set('n', 'zh', ':sp<CR>', opts)
set('n', 'zc', '<C-w>c', opts)
set('n', 'zo', '<C-w>o', opts) -- close others
-- bufferline 左右Tab切换
set('n', '<C-h>', ':BufferLineCyclePrev<CR>', opts)
set('n', '<C-l>', ':BufferLineCycleNext<CR>', opts)

set('v', '=', 'gq', opts)
if vim.g.vscode then

else
    -- Resize with arrows
    -- delta: 2 lines
    set('n', '<C-Up>', ':resize -2<CR>', opts)
    set('n', '<C-Down>', ':resize +2<CR>', opts)
    set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
    set('n', '<C-Right>', ':vertical resize +2<CR>', opts)
    set('n', '<C-B>', ':NvimTreeToggle<CR>', opts)
    set('n', '<A-q>', ':q<CR>', opts)
end
