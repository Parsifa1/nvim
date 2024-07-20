return {
    "lambdalisue/suda.vim",
    cmd = { "SudaWrite", "SudaRead" },
    keys = {
        { "<leader>sr", "<cmd>SudaRead<CR>",  desc = "Read Sudo Files" },
        { "<leader>sw", "<cmd>SudaWrite<CR>", desc = "Write Sudo Files" }
    },
}
