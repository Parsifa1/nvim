local set = require("custom").set

if vim.g.vscode then
    set("n", "zv", "<Cmd>call VSCodeNotify('workbench.action.splitEditor')<CR>")
    set("n", "zh", "<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>")
    set("v", "=", "gq")
    set("o", "=", "q")
else
    vim.api.nvim_set_keymap("i", "J", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    
    --格式化设置
    set("v", "=", "gq")
    set("n", "=", "gq")
    set("o", "=", "q")
    --窗口操作
    set("n", "<up>", ":res +5<CR>")
    set("n", "<down>", ":res -5<CR>")
    set("n", "<left>", ":vertical resize-5<CR>")
    set("n", "<right>", ":vertical resize+5<CR>")

    -- 展开/关闭终端
    set("n", "`", ":ToggleTerm<CR>", "Terminal")
    set("t", "`", "<C-\\><C-n>:ToggleTerm<CR>", "Terminal")

    --窗口跳转
    set("n", "<A-q>", ":q<CR>")
    set("t", "<A-q>", "<C-\\><C-n>:q<CR>")
    set("i", "<A-q>", "<Esc>:q<CR>")

    --分屏
    set("n", "zv", ":vsp<CR>", "vsplit")
    set("n", "zh", ":sp<CR>", "split")
    set("n", "zc", "<C-w>c", "close current")
    set("n", "zo", "<C-w>o", "close others") -- close others
    set("n", "zd", "zd", "delete fold")      -- close others

    set("n", "<C-h>", ":bp<CR>")
    set("n", "<C-l>", ":bn<CR>")
    set("n", "<C-w>", ":bdelete!<CR>")
    set("n", "<C-s>", ":write<CR>")
    set("i", "<C-s>", "<Esc>:w<CR>")
    set("n", "<C-a>", "gg0vG$")
    set("v", "<C-a>", "vgg0vG$")
    set("i", "<C-a>", "<Esc>gg4vG$a")
    set("v", "<C-c>", "y")
    set("i", "<C-v>", "<Esc>pa")
    set("n", "<C-v>", "p")
    --CP相关
    set("n", "<F1>", ":CompetiTest run<CR>")
    set("i", "<F1>", "<Esc>:CompetiTest run<CR>")
    set("n", "<F2>", ":CompetiTest add_testcase<CR>")
    set("i", "<F2>", "<Esc>:CompetiTest add_testcase<CR>")
    set("n", "<F3>", ":CompetiTest edit_testcase<CR>")
    set("i", "<F3>", "<Esc>:CompetiTest edit_testcase<CR>")
    --task指令
    set({ "n", "i" }, "<F5>", ":AsyncTask file-run<CR>", "run task")
    set({ "n", "i" }, "<F6>", ":AsyncTask file-build<CR>", "build task")
    set("n", "<F12>", ":Lazy<CR>")

    --leader
    set("n", "<leader>a", "<Cmd>AerialToggle<CR>", "Outline")
    set("n", "<leader>e", ":lua MiniFiles.open()<CR>", "File Explorer")
    set("n", "<leader>h", "<C-w>h", "goto left window")
    set("n", "<leader>j", "<C-w>j", "goto down window")
    set("n", "<leader>k", "<C-w>k", "goto up window")
    set("n", "<leader>l", "<C-w>l", "goto right window")
    set("n", "<leader>p", ":Lazy<CR>", "lazy")
    set("n", "<leader>i", ":Telescope neovim-project history theme=dropdown<CR><Esc>", "projects folder")
    set("n", "<leader>f", ":Telescope find_files<CR>", "find files")
    set("n", "<leader>w", ":Telescope live_grep<CR>", "find words")
    set("n", "<leader>r", ":Telescope oldfiles<CR>", "recent files")
    set("n", "<leader>cc", ":Telescope commands<CR>", "commands")
    set("n", "<leader>ck", ":Telescope keymaps<CR>", "keymaps")
    set("n", "<leader>gg", "<Cmd>Neogit<CR>", "Open Neogit")
    set("n", "<leader>v", ":lua vim.fn.chdir(vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h'))<CR>", "cd current file")
end

