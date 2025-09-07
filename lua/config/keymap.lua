local mode_n, mode_v, mode_i, mode_o, mode_s, mode_t = { "n" }, { "v" }, { "i" }, { "o" }, { "s" }, { "t" }
local mode_nv, mode_ni, mode_nit, mode_nvo = { "n", "v" }, { "n", "i" }, { "n", "i", "v" }, { "n", "v", "o" }

local keymap = {
    -- stylua: ignore start
    { "<A-l>",            "<Right>",                                   mode = mode_i }, -- insert模式下的方向键
    { "<A-h>",            "<Left>",                                    mode = mode_i },
    { "n",                "nzzzv",                                     mode = mode_n }, -- 搜索保持光标
    { "j",                "gj",                                        mode = mode_n }, -- 软换行
    { "k",                "gk",                                        mode = mode_n },
    { "<C-i>",            "<C-i>",                                     mode = mode_n }, -- 重设<C-i>
    { "<Esc>",            "<cmd>noh<CR>",                              mode = mode_n }, -- set noh
    { "<C-x>",            "<cmd>lua Snacks.bufdelete()<CR>",           mode = mode_n },
    { "<C-c>",            '"+y',                                       mode = mode_v },
    { "K",                ":m '<-2<cr>gv=gv",                          mode = mode_v }, -- 行移动
    { "J",                ":m '>+1<cr>gv=gv",                          mode = mode_v },
    { "<BS>",             "<BS>:startinsert<CR>",                      mode = mode_s },
    { "=",                "q",                                         mode = mode_o },
    { "<Esc>",            "<C-\\><C-N>",                               mode = mode_t },
    { "=",                "gq",                                        mode = mode_nv },
    { "<C-s>",            "<cmd>write<CR>",                            mode = mode_ni },
    { "<C-a>",            "<cmd>normal gg0vG$<CR>",                    mode = mode_ni },
    { "<F1>",             "<cmd>CompetiTest run<CR>",                  mode = mode_ni },
    { "<F2>",             "<cmd>CompetiTest add_testcase<CR>",         mode = mode_ni },
    { "<F3>",             "<cmd>CompetiTest edit_testcase<CR>",        mode = mode_ni },
    { "<F4>",             "<cmd>AsyncTask acm<cr>",                    mode = mode_ni },
    { "<F5>",             "<cmd>AsyncTask run<cr>",                    mode = mode_ni },
    { "<F6>",             "<cmd>AsyncTask build<cr>",                  mode = mode_ni },
    { "H",                "^",                                         mode = mode_nvo },
    { "L",                "$",                                         mode = mode_nvo },
    { "<C-h>",            "<C-w>h",                                    mode = mode_nit },
    { "<C-j>",            "<C-w>j",                                    mode = mode_nit },
    { "<C-k>",            "<C-w>k",                                    mode = mode_nit },
    { "<C-l>",            "<C-w>l",                                    mode = mode_nit },
    { "<A-q>",            "<cmd>qa<CR>",                               mode = mode_nit }, -- 窗口关闭
    { "<A-Q>",            "<cmd>qa<CR>",                               mode = mode_nit }, -- vim关闭
    { "<leader>p",        "<cmd>Lazy<CR>",                             mode = mode_n,   desc = "lazy" }, -- desc快捷键 ↓
    { "<leader>sw",       "<cmd>set wrap!<CR>",                        mode = mode_n,   desc = "toggle warp" },
    { "<leader><Up>",     "<cmd>res +5<CR>",                           mode = mode_n,   desc = "resize window up" }, -- 窗口操作
    { "<leader>bd",       "<cmd>bd<CR>",                               mode = mode_n,   desc = "[B]uffer [D]elete" },
    { "<leader><Down>",   "<cmd>res -5<CR>",                           mode = mode_n,   desc = "resize window down" },
    { "<leader><Left>",   "<cmd>vertical resize -5<CR>",               mode = mode_n,   desc = "resize window left" },
    { "<leader><Right>",  "<cmd>vertical resize +5<CR>",               mode = mode_n,   desc = "resize window right" },
    { "<leader><S-Left>", "<cmd>vertical resize -15<CR>",              mode = mode_n,   desc = "resize window left" },
    { "<leader><S-Right>","<cmd>vertical resize +15<CR>",              mode = mode_n,   desc = "resize window right" },
    { "zo",               "<C-w>o",                                    mode = mode_n,   desc = "only current window" },
    { "zs",               "<C-w>s",                                    mode = mode_n,   desc = "split current window" },
    { "zc",               "<C-w>c",                                    mode = mode_n,   desc = "close current window" },
    { "zv",               "<C-w>v",                                    mode = mode_n,   desc = "vsplit current window" },
    { "zT",               "<C-w>T",                                    mode = mode_n,   desc = "break out into new tab" },
    { "zH",               "<C-w>H",                                    mode = mode_n,   desc = "move window to far left" },
    { "zL",               "<C-w>L",                                    mode = mode_n,   desc = "move window to far right" },
    { "<leader>ss",       ":%s/\\<<C-r><C-w>\\>//g<left><left>",       mode = mode_n,   desc = "global replacement", silent = false },
  -- stylua: ignore end
}

for _, mapping in ipairs(keymap) do
  local opts = { noremap = true, silent = mapping.silent ~= false }
  if mapping.desc then opts.desc = mapping.desc end
  vim.keymap.set(mapping.mode, mapping[1], mapping[2], opts)
end
