local mode_n, mode_v, mode_i, mode_o, mode_nv, mode_ni, mode_niv, mode_nit =
    { "n" }, { "v" }, { "i" }, { "o" }, { "n", "v" }, { "n", "i" }, { "n", "i", "v" }, { "n", "i", "t" }
local keymap = {
    -- stylua: ignore start
    { mode = mode_n,      from = "<up>",         to = "<cmd>res +5<CR>" }, -- 窗口操作
    { mode = mode_n,      from = "<down>",       to = "<cmd>res -5<CR>" },
    { mode = mode_n,      from = "<left>",       to = "<cmd>vertical resize-5<CR>" },
    { mode = mode_n,      from = "<right>",      to = "<cmd>vertical resize+5<CR>" },
    { mode = mode_n,      from = "n",            to = "nzzzv" }, -- 搜索保持光标
    { mode = mode_n,      from = "n",            to = "nzzzv" },
    { mode = mode_v,      from = "K",            to = ":m '<-2<cr>gv=gv" }, -- 行移动
    { mode = mode_v,      from = "J",            to = ":m '>+1<cr>gv=gv" },
    { mode = mode_nit,    from = "<a-q>",        to = "<cmd>q<CR>" }, -- 窗口关闭
    { mode = mode_n,      from = "z",            to = "<c-w>" }, -- 分屏
    { mode = mode_n,      from = "<c-x>",        to = "<cmd>bd<CR>" }, -- buffer关闭
    { mode = mode_n,      from = "zz",           to = "za" }, -- 折叠/展开当前位置
    { mode = mode_n,      from = "zr",           to = "zR" }, -- 全部展开
    { mode = mode_n,      from = "zm",           to = "zM" }, -- 全部折叠
    { mode = mode_i,      from = "<a-l>",        to = "<Right>" }, -- insert模式下的方向键
    { mode = mode_i,      from = "<a-h>",        to = "<Left>" },

    -- 其他
    { mode = mode_nv,     from = "H",            to = "^" },
    { mode = mode_nv,     from = "L",            to = "$" },
    { mode = mode_nv,     from = "=",            to = "gq" },
    { mode = mode_o,      from = "=",            to = "q" },
    { mode = mode_v,      from = "<c-c>",        to = "y" },
    { mode = mode_ni,     from = "<c-h>",        to = "<cmd>bp<CR>" },
    { mode = mode_ni,     from = "<c-l>",        to = "<cmd>bn<CR>" },
    { mode = mode_ni,     from = "<C-s>",        to = "<cmd>write<CR>" },
    { mode = mode_niv,    from = "<c-a>",        to = "<cmd>normal gg0vG$<CR>" },
    { mode = mode_i,      from = "<c-f>",        to = function() require("luasnip").expand() end },
    { mode = mode_ni,     from = "<f1>",         to = "<cmd>CompetiTest run<CR>"},
    { mode = mode_ni,     from = "<f2>",         to = "<cmd>CompetiTest add_testcase<CR>" },
    { mode = mode_ni,     from = "<f3>",         to = "<cmd>CompetiTest edit_testcase<CR>" },
    { mode = mode_n,      from = "<f4>",         to = "<cmd>AsyncTask acm<cr>",                            desc = "run acm" },
    { mode = mode_n,      from = "<f5>",         to = "<cmd>AsyncTask run<cr>",                            desc = "run task" },
    { mode = mode_n,      from = "<f6>",         to = "<cmd>AsyncTask build<cr>",                          desc = "build task" },
    { mode = mode_n,      from = "<tab><tab>",   to = "<cmd>tabnew<cr>",                                   desc = "new tab" },
    { mode = mode_n,      from = "[[",           to = "<cmd>tabp<cr>",                                     desc = "previous tab" },
    { mode = mode_n,      from = "]]",           to = "<cmd>tabn<cr>",                                     desc = "next tab" },
    -- { mode = mode_n,      from = "<leader>a",    to = "<cmd>Outline<cr>",                                  desc = "outline" },
    -- { mode = mode_n,      from = "<leader>e",    to = "<cmd>lua MiniFiles.open()<CR>",                     desc = "file explorer" },
    { mode = mode_n,      from = "<leader>f",    to = "<cmd>Telescope find_files<CR>",                     desc = "find files" },
    { mode = mode_n,      from = "<leader>F",    to = "<cmd>lua require('conform').format()<CR>",          desc = "format files" },
    { mode = mode_n,      from = "<leader>p",    to = "<cmd>Lazy<CR>",                                     desc = "lazy" },
    { mode = mode_n,      from = "<leader>r",    to = "<cmd>Telescope oldfiles<CR>",                       desc = "recent files" },
    { mode = mode_n,      from = "<leader>v",    to = "<cmd>cd %:p:h<CR>",                                 desc = "cd current file" },
    -- { mode = mode_n,      from = "<leader>u",    to = "<cmd>MundoToggle<cr>",                              desc = "undo tree" },
    { mode = mode_n,      from = "<leader>w",    to = "<cmd>Telescope live_grep<CR>",                      desc = "find words" },
    { mode = mode_n,      from = "<leader>sw",   to = "<cmd>set wrap!<CR>",                                desc = "toggle warp" },
    { mode = mode_n,      from = "<leader>gg",   to = "<cmd>Neogit<CR>",                                   desc = "open neogit" },
    { mode = mode_n,      from = "<leader>tb",   to = "<cmd>Telescope buffers <CR><esc>",                  desc = "telescope buffers" },
    { mode = mode_n,      from = "<leader>tc",   to = "<cmd>Telescope commands<CR>",                       desc = "telescope commands" },
    { mode = mode_n,      from = "<leader>tk",   to = "<cmd>Telescope keymaps<CR>",                        desc = "telescope keymaps" },
    { mode = mode_n,      from = "<leader><cr>", to = "<cmd>noh<CR>",                                      desc = "clear highlight" },
    { mode = mode_n,      from = "<leader>i",    to = "<cmd>Telescope workspaces theme=dropdown<CR><esc>", desc = "projects folder" },
    { mode = mode_n,      from = "<leader>ss",   to = ":%s/\\<<C-r><C-w>\\>//g<left><left>",               desc = "global replacement" },
    -- stylua: ignore end
}
for _, mapping in ipairs(keymap) do
    if mapping.desc then
        vim.keymap.set(mapping.mode, mapping.from, mapping.to, { noremap = true, silent = true, desc = mapping.desc })
    else
        vim.keymap.set(mapping.mode, mapping.from, mapping.to, { noremap = true, silent = true })
    end
end
