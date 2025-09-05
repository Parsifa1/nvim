return {
    "lambdalisue/suda.vim",
    cmd = { "SudaWrite", "SudaRead" },
    -- event = "User AfterFile",
    -- init = function()
    --     vim.g.suda_smart_edit = 1
    -- end,
    keys = {
        { "<leader>sr", "<cmd>SudaRead<CR>", desc = "Read Sudo Files" },
        { "<leader>sw", "<cmd>SudaWrite<CR>", desc = "Write Sudo Files" },
    },
}
