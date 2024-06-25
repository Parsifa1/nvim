return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
        { "<leader>q", "<Cmd>Trouble diagnostics <CR>", desc = "Trouble" },
    },
    opts = {
        focus = true,
        win = { size = { width = 0.3, height = 0.3 } },
    },
}
