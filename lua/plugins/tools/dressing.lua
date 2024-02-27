return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
        select = {
            backend = { "builtin", "nui" },
            builtin = {
                min_width = 62,
                mappings = {
                    ["<Esc>"] = "Close",
                    ["q"] = "Close",
                    ["<CR>"] = "Confirm",
                },
            },
        },
    },
}
