---@type LazyPluginSpec
return {
    "stevearc/dressing.nvim",
    opts = {
        select = {
            backend = { "snacks_picker", "fzf_lua" },
            get_config = function(opts)
                if opts.kind == "codeaction" then return {} end
            end,
            fzf_lua = {
                winopts = {
                    height = 0.25,
                    width = 0.4,
                    row = 0.50,
                    col = 0.50,
                },
            },
        },
    },
}
