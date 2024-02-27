return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
        select = {
            backend = { "builtin", "nui" },
            builtin = {
                min_width = 62,
                mappings = {
                    ["q"] = "Close",
                    ["<Esc>"] = "Close",
                    ["<CR>"] = "Confirm",
                },
            },
        },
    },
}
