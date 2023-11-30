local set = vim.keymap.set
local opts = {
    noremap = true, -- non-recursive
    silent = true,  -- do not show message
}
local function desc(index)
    return {
        noremap = true,
        silent = true,
        desc = index,
    }
end

if vim.g.vscode then
    set("n", "zv", "<Cmd>call VSCodeNotify('workbench.action.splitEditor')<CR>", opts)
    set("n", "zh", "<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>", opts)
    set("v", "=", "gq", opts)
    set("o", "=", "q", opts)
else
    vim.api.nvim_set_keymap("i", "<A-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

    --格式化设置
    set("v", "=", "gq", opts)
    set("n", "=", "gq", opts)
    set("o", "=", "q", opts)
    --窗口操作
    set("n", "<up>", ":res +5<CR>", opts)
    set("n", "<down>", ":res -5<CR>", opts)
    set("n", "<left>", ":vertical resize-5<CR>", opts)
    set("n", "<right>", ":vertical resize+5<CR>", opts)


    --窗口跳转
    set("n", "<A-h>", "<C-w>h", opts)
    set("n", "<A-j>", "<C-w>j", opts)
    set("n", "<A-k>", "<C-w>k", opts)
    set("n", "<A-l>", "<C-w>l", opts)
    set("n", "<A-q>", ":q<CR>", opts)
    set("t", "<A-q>", "<C-\\><C-n>:q<CR>", opts)
    set("i", "<A-q>", "<Esc>:q<CR>", opts)
    set("n", "<A-e>", ":ToggleTerm<CR>", desc("Terminal"))

    --分屏
    set("n", "zv", ":vsp<CR>", desc("vsplit"))
    set("n", "zh", ":sp<CR>", desc("split"))
    set("n", "zc", "<C-w>c", desc("close current"))
    set("n", "zo", "<C-w>o", desc("close others")) -- close others
    set("n", "zd", "zd", desc("delete fold")) -- close others

    set("n", "<C-h>", ":bp<CR>", opts)
    set("n", "<C-l>", ":bn<CR>", opts)
    set("n", "<C-w>", ":bdelete!<CR>", opts)
    set("n", "<C-s>", ":write<CR>", opts)
    set("i", "<C-s>", "<Esc>:w<CR>", opts)
    set("n", "<C-a>", "gg0vG$", opts)
    set("v", "<C-a>", "vgg0vG$", opts)
    set("i", "<C-a>", "<Esc>gg4vG$a", opts)
    set("v", "<C-c>", "y", opts)
    set("i", "<C-v>", "<Esc>pa", opts)
    set("n", "<C-v>", "p", opts)
    --CP相关
    set("n", "<F1>", ":CompetiTest run<CR>", opts)
    set("i", "<F1>", "<Esc>:CompetiTest run<CR>", opts)
    set("n", "<F2>", ":CompetiTest add_testcase<CR>", opts)
    set("i", "<F2>", "<Esc>:CompetiTest add_testcase<CR>", opts)
    set("n", "<F3>", ":CompetiTest edit_testcase<CR>", opts)
    set("i", "<F3>", "<Esc>:CompetiTest edit_testcase<CR>", opts)
    --task指令
    set({ "n", "i" }, "<F5>", ":AsyncTask file-run<CR>", desc("run task"))
    set({ "n", "i" }, "<F6>", ":AsyncTask file-build<CR>", desc("build task"))
    set("n", "<F12>", ":Lazy<CR>", opts)

    --leader
    set("n", "<leader>a", "<Cmd>AerialToggle<CR>", desc("Outline"))
    set("n", "<leader>e", ":lua MiniFiles.open()<CR>", desc("File Explorer"))
    set("n", "<leader>ff", ":Telescope find_files<CR>", desc("find files"))
    set("n", "<leader>fw", ":Telescope live_grep<CR>", desc("find words"))
    set("n", "<leader>fr", ":Telescope oldfiles<CR>", desc("recent files"))
    set("n", "<leader>l", ":Lazy<CR>", desc("lazy"))
    set("n", "<leader>cc", ":Telescope commands<CR>", desc("commands"))
    set("n", "<leader>ck", ":Telescope keymaps<CR>", desc("keymaps"))
    set("n", "<leader>gg", "<Cmd>Neogit<CR>", desc("Open Neogit"))
    set("n", "<leader>p", ":Telescope neovim-project discover theme=dropdown<CR><Esc>", desc("projects folder"))
end
