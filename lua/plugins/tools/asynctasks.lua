return {
    {
        "skywind3000/asynctasks.vim",
        dependencies = { "skywind3000/asyncrun.vim" },
        ft = { "cpp", "python" },
        event = "User AfterFile",
        init = function() vim.g.asynctasks_term_pos = "toggleterm" end,
    },
    {
        "parsifa1/code-runner",
        ft = { "cpp", "python" },
        dev = true,
        opts = {},
    },
}
