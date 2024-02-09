local set = require("custom").set

if vim.g.vscode then
    set("n", "zv", "<Cmd>call VSCodeNotify('workbench.action.splitEditor')<CR>")
    set("n", "zh", "<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>")
    set("v", "=", "gq")
    set("o", "=", "q")
else
    -- 格式化设置
    set({ "v", "n" }, "=", "gq")
    set("o", "=", "q")

    -- 窗口操作
    set("n", "<up>", ":res +5<CR>")
    set("n", "<down>", ":res -5<CR>")
    set("n", "<left>", ":vertical resize-5<CR>")
    set("n", "<right>", ":vertical resize+5<CR>")

    -- 搜索保持光标
    set("n", "n", "nzzzv")
    set("n", "N", "Nzzzv")

    -- 行移动
    set("v", "J", ":m '>+1<CR>gv=gv")
    set("v", "K", ":m '<-2<CR>gv=gv")

    -- 窗口关闭
    set("n", "<A-q>", ":q<CR>")
    set("t", "<A-q>", "<C-\\><C-n>:q<CR>")
    set("i", "<A-q>", "<Esc>:q<CR>")

    -- buffer关闭
    set("n", "zd", ":bd<CR>")

    -- insert模式下的方向键
    set("i", "<A-l>", "<Right>")
    set("i", "<A-h>", "<Left>")

    -- tab操作
    set("n", "<Tab><Tab>", ":tabnew<CR>")
    set("n", "[[", ":tabp<CR>", "previous tab")
    set("n", "]]", ":tabn<CR>", "next tab")

    -- 分屏
    set("n", "z", "<C-w>")

    -- 折叠
    set("n", "zz", "za") -- 折叠/展开当前位置
    set("n", "zr", "zR") -- 全部展开
    set("n", "zm", "zM") -- 全部折叠

    -- 其他
    set({ "n", "v", "o" }, "H", "^")
    set({ "n", "v", "o" }, "L", "$")
    set("n", "[b", ":bp<CR>")
    set("n", "]b", ":bn<CR>")
    -- set("n", "<C-h>", ":bp<CR>")
    -- set("n", "<C-l>", ":bn<CR>")
    set("n", "<C-j>", "<C-w>j")
    set("n", "<C-k>", "<C-w>k")
    set("n", "<C-s>", ":w<CR>")
    set("i", "<C-s>", "<Esc>:w<CR>a")
    set("n", "<C-a>", "gg0vG$")
    set("v", "<C-a>", "vgg0vG$")
    set("i", "<C-a>", "<Esc>gg4vG$a")
    set("v", "<C-c>", "y")

    -- CP相关
    set("n", "<F1>", ":CompetiTest run<CR>")
    set("i", "<F1>", "<Esc>:CompetiTest run<CR>")
    set("n", "<F2>", ":CompetiTest add_testcase<CR>")
    set("i", "<F2>", "<Esc>:CompetiTest add_testcase<CR>")
    set("n", "<F3>", ":CompetiTest edit_testcase<CR>")
    set("i", "<F3>", "<Esc>:CompetiTest edit_testcase<CR>")

    -- task指令
    set("n", "<F4>", ":AsyncTask acm<CR>", "run acm")
    set("n", "<F5>", ":AsyncTask file-run<CR>", "run task")
    set("n", "<F6>", ":AsyncTask file-build<CR>", "build task")

    --leader键
    set("n", "<leader>a", ":Outline<CR>", "Outline")
    set("n", "<leader>e", ":lua MiniFiles.open()<CR>", "File Explorer")
    set("n", "<leader>f", ":Telescope find_files<CR>", "find files")
    set("n", "<leader>F", ':lua require("conform").format()<CR>', "Format files")
    set("n", "<leader>gg", ":Neogit<CR>", "Open Neogit")
    set("n", "<leader>i", ":Telescope workspaces theme=dropdown<CR><Esc>", "projects folder")
    set("n", "<leader>p", ":Lazy<CR>", "lazy")
    set("n", "<leader>ss", ":%s/\\<<c-r><c-w>\\>/<c-r><c-w>/gi<left><left><left>", "Global replacement")
    set("n", "<leader>sw", ":set wrap!<CR>", "toggle warp")
    set("n", "<leader>r", ":Telescope oldfiles<CR>", "recent files")
    set("n", "<leader>tc", ":Telescope commands<CR>", "Telescope commands")
    set("n", "<leader>tk", ":Telescope keymaps<CR>", "Telescope keymaps")
    set("n", "<leader>tb", ":Telescope buffers theme=dropdown<CR><Esc>", "Telescope buffers")
    set("n", "<leader>u", ":MundoToggle<CR>", "Undo Tree")
    set("n", "<leader>v", ":lua vim.fn.chdir(vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h'))<CR>", "cd current file")
    set("n", "<leader>w", ":Telescope live_grep<CR>", "find words")
    set("n", "<leader><CR>", ":noh<CR>", "clear highlight")
end
