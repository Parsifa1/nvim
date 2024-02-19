return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "TroubleToggle",
    -- event = "VeryLazy",
    keys = {
        { "<leader>q", "<Cmd>TroubleToggle<CR>", desc = "Trouble" },
    },
    opts = {},
}
