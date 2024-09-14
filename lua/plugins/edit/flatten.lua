return {
    "willothy/flatten.nvim",
    event = { "BufNewFile", "BufReadPost" },
    opts = {
        nest_if_no_args = true,
        window = {
            open = "alternate",
        },
    },
}
