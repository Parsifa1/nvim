return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
        select = {
            backend = { "builtin", "nui", "telescope" },
            get_config = function(opts)
                if opts.kind == "codeaction" then
                    return {
                        builtin = {
                            relative = "cursor",
                            max_width = 50,
                        },
                    }
                end
            end,
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
