vim.g.mapleader = ' '
-- define common options
local set = vim.keymap.set
local opts = {
    noremap = true, -- non-recursive
    silent = true,  -- do not show message
}

local function desc(index)
    return {
        noremap = true,
        silent = true,
        desc = index
    }
end


if vim.g.vscode then
    set('n', 'zv', "<Cmd>call VSCodeNotify('workbench.action.splitEditor')<CR>", opts)
    set('n', 'zh', "<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>", opts)
    set('n', '==', 'gqq', opts)
    set('v', '=', 'gq', opts)
else
    --窗口跳转
    set('n', '<A-h>', '<C-w>h', opts)
    set('n', '<A-j>', '<C-w>j', opts)
    set('n', '<A-k>', '<C-w>k', opts)
    set('n', '<A-l>', '<C-w>l', opts)
    --分屏
    set('n', 'zv', ':vsp<CR>', desc('vsplit'))
    set('n', 'zh', ':sp<CR>', desc('split'))
    set('n', 'zc', '<C-w>c', desc('close current'))
    set('n', 'zo', '<C-w>o', desc('close others')) -- close others
    -- bufferline 左右Tab切换
    set('n', '<C-h>', ':bp<CR>', opts)
    set('n', '<C-l>', ':bp<CR>', opts)
    -- Resize with arrows
    -- delta: 5 lines
    set('n', '<C-Up>', ':resize 1<CR>', opts)
    set('n', '<C-Down>', ':resize +5<CR>', opts)
    set('n', '<C-Left>', ':vertical resize 1<CR>', opts)
    set('n', '<C-Right>', ':vertical resize +5<CR>', opts)
    set('n', '<C-/>', 'gcc', opts)
    set('n', '<A-S>', 'ggvGgcc', opts)
    --CP相关
    --
    set('n', '<F1>', ':CompetiTest add_testcase<CR>', opts)
    set('i', '<F1>', '<Esc>:CompetiTest add_testcase<CR>', opts)
    set('n', '<F4>', ':CompetiTest run<CR>', opts)
    set('i', '<F4>', '<Esc>:CompetiTest run<CR>', opts)
    set('n', '<A-q>', ':q<CR>', opts)

    set('t', '<Esc>', '<C-\\><C-n>:q<CR>', opts)
    set('t', '<A-q>', '<C-\\><C-n>:q<CR>', opts)
    set('n', '<F5>', ':FloatermNew! cd %:h; g++ %:t -std=c++20 -o bin\\cp.exe; .\\bin\\cp<CR>', opts)
    set('i', '<F5>', '<Esc>:FloatermNew! cd %:h && g++ %:t -std=c++20 -o bin\\cp.exe && .\\bin\\cp<CR><CR>', opts)

    set('n', '<F12>', ':Lazy<CR>', opts)
    set('n', '<C-w>', ':bdelete!<CR>', opts)
    set('n', '<C-s>', ':w<CR>', opts)
    set('n', '<C-a>', 'ggvG', opts)
    set('v', '<C-c>', 'y', opts)
    --

    --telescope
    set('n', '<leader>f', ':Telescope find_files<CR>', desc('find files'))
    set('n', '<leader>w', ':Telescope live_grep<CR>', desc('find words'))
    set('n', '<leader>r', ':Telescope oldfiles<CR>', desc('recent files'))
end
