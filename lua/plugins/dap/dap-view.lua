return {
    "parsifa1/debugmaster.nvim",
    branch = "feat-toggle-pannel",
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
