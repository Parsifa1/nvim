return {
    "skywind3000/asynctasks.vim",
    dependencies = { "skywind3000/asyncrun.vim" },
    event = "BufReadPre",
    cond = vim.bo.filetype ~= "alpha",
}
