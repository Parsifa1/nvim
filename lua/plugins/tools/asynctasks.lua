return {
    "skywind3000/asynctasks.vim",
    dependencies = { "skywind3000/asyncrun.vim" },
    ft = { "cpp", "python" },
    event = "User AfterLoad",
    init = function()
        vim.g.asynctasks_term_pos = "toggleterm"
    end,
}
