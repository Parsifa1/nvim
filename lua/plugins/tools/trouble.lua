return {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    -- event = "VeryLazy",
    keys = {
        { "<leader>q", "<Cmd>Trouble diagnostics <CR>", desc = "Trouble" },
    },
    opts = {},
}
