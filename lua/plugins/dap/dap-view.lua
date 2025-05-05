return {
    "miroshQa/debugmaster.nvim",
    keys = {
        {
            "<leader>dd",
            function()
                require("debugmaster").mode.toggle()
            end,
            desc = "Toggle DebugMaster",
        },
    },
    config = function()
        vim.keymap.set("t", "<C-/>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
    end,
}
