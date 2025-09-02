---@type LazyPluginSpec
return {
    "folke/lazydev.nvim",
    dependencies = { "Bilal2453/luvit-meta" },
    ft = "lua",
    event = "LspAttach",
    opts = {
        library = {
            "../utils",
            { path = "luvit-meta/library", words = { "vim%.uv", "vim%.loop" } },
            { path = "lazy.nvim", words = { "LazyPluginSpec" } },
        },
    },
}
