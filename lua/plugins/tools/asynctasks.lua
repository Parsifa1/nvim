return {
    "skywind3000/asynctasks.vim",
    dependencies = { "skywind3000/asyncrun.vim" },
    fn = { "cpp", "python" },
    event = { "BufNewFile", "BufReadPre" },
}
