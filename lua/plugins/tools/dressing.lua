return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
        select = {
            backend = { "builtin", "nui", "telescope" },
            builtin = {
                min_width = 70,
                mappings = {
                    ["q"] = "Close",
                    ["<Esc>"] = "Close",
                    ["<CR>"] = "Confirm",
                },
            },
        },
    },
}
