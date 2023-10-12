vim.g.mapleader = '<Space>'
-- define common options
local set = vim.keymap.set
local opts = {
    noremap = true, -- non-recursive
    silent = true,  -- do not show message
}

-- vim.g.mapleader = "<Space>"



set('v', '=', 'gq', opts)
if vim.g.vscode then
    set('n', 'zv', "<Cmd>call VSCodeNotify('workbench.action.splitEditor')<CR>", opts)
    set('n', 'zh', "<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>", opts)
else
    set('n', '==', 'gqq', opts)
    set('v', '=', 'gq', opts)
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
    -- Resize with arrows
    -- delta: 2 lines
    set('n', '<C-Up>', ':resize -2<CR>', opts)
    set('n', '<C-Down>', ':resize +2<CR>', opts)
    set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
    set('n', '<C-Right>', ':vertical resize +2<CR>', opts)
    set('n', '<C-B>', ':NvimTreeToggle<CR>', opts)
    set('n', '<A-q>', ':q<CR>', opts)

    set('t', '<Esc>', '<C-\\><C-n>:q<CR>', opts)
    set('n', '<F5>', ':FloatermNew! g++ % -o bin/cp.exe && .\\bin\\cp<CR>', opts)
    set('i', '<F5>', '<Esc>:FloatermNew! g++ % -o bin/cp.exe && .\\bin\\cp<CR>', opts)
end
