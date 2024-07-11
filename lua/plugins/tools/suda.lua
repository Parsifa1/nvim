return {
    "lambdalisue/suda.vim",
    event = { "BufNewFile", "BufReadPost" },
    init = function()
        vim.g.suda_smart_edit = 1
    end,
}
