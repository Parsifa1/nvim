local mode_n, mode_v, mode_i, mode_o, mode_t, mode_nv = { "n" }, { "v" }, { "i" }, { "o" }, { "t" }, { "n", "v" }
local keymap = {
    -- stylua: ignore start
    -- 窗口操作
    { mode = mode_n,  from = "<up>",         to = ":res +5<CR>" },
    { mode = mode_n,  from = "<down>",       to = ":res -5<CR>" },
    { mode = mode_n,  from = "<left>",       to = ":vertical resize-5<CR>" },
    { mode = mode_n,  from = "<right>",      to = ":vertical resize+5<CR>" },
    -- 搜索保持光标
    { mode = mode_n,  from = "n",            to = "nzzzv" },
    { mode = mode_n,  from = "N",            to = "Nzzzv" },
    -- 行移动
    { mode = mode_v,  from = "J",            to = ":m '>+1<CR>gv=gv" },
    { mode = mode_v,  from = "K",            to = ":m '<-2<CR>gv=gv" },
    -- 窗口关闭
    { mode = mode_n,  from = "<A-q>",        to = ":q<CR>" },
    { mode = mode_t,  from = "<A-q>",        to = "<C-\\><C-n>:q<CR>" },
    { mode = mode_i,  from = "<A-q>",        to = "<Esc>:q<CR>" },
    -- 分屏
    { mode = mode_n,  from = "z",            to = "<C-w>" },
    -- buffer关闭
    { mode = mode_n,  from = "<C-x>",        to = ":bd<CR>" },
    -- 折叠
    { mode = mode_n,  from = "zz",           to = "za" }, -- 折叠/展开当前位置
    { mode = mode_n,  from = "zr",           to = "zR" }, -- 全部展开
    { mode = mode_n,  from = "zm",           to = "zM" }, -- 全部折叠
    -- insert模式下的方向键
    { mode = mode_i,  from = "<A-l>",        to = "<Right>" },
    { mode = mode_i,  from = "<A-h>",        to = "<Left>" },
    -- 其他
    { mode = mode_nv, from = "=",            to = "gq" },
    { mode = mode_nv, from = "H",            to = "^" },
    { mode = mode_nv, from = "L",            to = "$" },
    { mode = mode_o,  from = "=",            to = "q" },
    { mode = mode_n,  from = "[b",           to = ":bp<CR>" },
    { mode = mode_n,  from = "]b",           to = ":bn<CR>" },
    { mode = mode_n,  from = "<C-j>",        to = "<C-w>j" },
    { mode = mode_n,  from = "<C-k>",        to = "<C-w>k" },
    { mode = mode_n,  from = "<C-h>",        to = ":bp<CR>" },
    { mode = mode_i,  from = "<C-h>",        to = "<Esc>:bp<CR>a" },
    { mode = mode_n,  from = "<C-l>",        to = ":bn<CR>" },
    { mode = mode_i,  from = "<C-l>",        to = "<Esc>:bn<CR>a" },
    { mode = mode_n,  from = "<C-s>",        to = ":w<CR>" },
    { mode = mode_i,  from = "<C-s>",        to = "<Esc>:w<CR>a" },
    { mode = mode_n,  from = "<C-a>",        to = "gg0vG$" },
    { mode = mode_v,  from = "<C-a>",        to = "vgg0vG$" },
    { mode = mode_i,  from = "<C-a>",        to = "<Esc>gg4vG$a" },
    { mode = mode_v,  from = "<C-c>",        to = "y" },

    -- CP相关
    { mode = mode_n,  from = "<F1>",         to = ":CompetiTest run<CR>" },
    { mode = mode_i,  from = "<F1>",         to = "<Esc>:CompetiTest run<CR>" },
    { mode = mode_n,  from = "<F2>",         to = ":CompetiTest add_testcase<CR>" },
    { mode = mode_i,  from = "<F2>",         to = "<Esc>:CompetiTest add_testcase<CR>" },
    { mode = mode_n,  from = "<F3>",         to = ":CompetiTest edit_testcase<CR>" },
    { mode = mode_i,  from = "<F3>",         to = "<Esc>:CompetiTest edit_testcase<CR>" },
    -- task指令
    { mode = mode_n,  from = "<F4>",         to = ":AsyncTask acm<CR>",                            desc = "run acm" },
    { mode = mode_n,  from = "<F5>",         to = ":AsyncTask run<CR>",                            desc = "run task" },
    { mode = mode_n,  from = "<F6>",         to = ":AsyncTask build<CR>",                          desc = "build task" },
    -- tab操作
    { mode = mode_n,  from = "<Tab><Tab>",   to = ":tabnew<CR>",                                   desc = "new tab" },
    { mode = mode_n,  from = "[[",           to = ":tabp<CR>",                                     desc = "previous tab" },
    { mode = mode_n,  from = "]]",           to = ":tabn<CR>",                                     desc = "next tab" },
    --leader键
    { mode = mode_n,  from = "<leader>a",    to = ":Outline<CR>",                                  desc = "Outline" },
    { mode = mode_n,  from = "<leader>e",    to = ":lua MiniFiles.open()<CR>",                     desc = "File Explorer" },
    { mode = mode_n,  from = "<leader>f",    to = ":Telescope find_files<CR>",                     desc = "find files" },
    { mode = mode_n,  from = "<leader>F",    to = ':lua require("conform").format()<CR>',          desc = "Format files" },
    { mode = mode_n,  from = "<leader>p",    to = ":Lazy<CR>",                                     desc = "lazy" },
    { mode = mode_n,  from = "<leader>r",    to = ":Telescope oldfiles<CR>",                       desc = "recent files" },
    { mode = mode_n,  from = "<leader>v",    to = ":cd %:p:h<CR>",                                 desc = "cd current file" },
    { mode = mode_n,  from = "<leader>u",    to = ":MundoToggle<CR>",                              desc = "Undo Tree" },
    { mode = mode_n,  from = "<leader>w",    to = ":Telescope live_grep<CR>",                      desc = "find words" },
    { mode = mode_n,  from = "<leader>sw",   to = ":set wrap!<CR>",                                desc = "toggle warp" },
    { mode = mode_n,  from = "<leader>gg",   to = ":Neogit<CR>",                                   desc = "Open Neogit" },
    { mode = mode_n,  from = "<leader>tb",   to = ":Telescope buffers <CR><Esc>",                  desc = "Telescope buffers" },
    { mode = mode_n,  from = "<leader>tc",   to = ":Telescope commands<CR>",                       desc = "Telescope commands" },
    { mode = mode_n,  from = "<leader>tk",   to = ":Telescope keymaps<CR>",                        desc = "Telescope keymaps" },
    { mode = mode_n,  from = "<leader><CR>", to = ":noh<CR>",                                      desc = "clear highlight" },
    { mode = mode_n,  from = "<leader>i",    to = ":Telescope workspaces theme=dropdown<CR><Esc>", desc = "projects folder",},

    {
        mode = mode_n,
        from = "<leader>ss",
        to = ":%s/\\<<c-r><c-w>\\>/<c-r><c-w>/gi<left><left><left>",
        desc = "Global replacement",
        no_silent = true,
    },
}
-- stylua: ignore end

for _, mapping in ipairs(keymap) do
    if mapping.no_silent then
        vim.keymap.set(mapping.mode, mapping.from, mapping.to, { noremap = true })
    end
    if mapping.desc then
        vim.keymap.set(mapping.mode, mapping.from, mapping.to, { noremap = true, silent = true, desc = mapping.desc })
    else
        vim.keymap.set(mapping.mode, mapping.from, mapping.to, { noremap = true, silent = true })
    end
end
