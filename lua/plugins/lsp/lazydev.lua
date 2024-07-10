return {
    "folke/lazydev.nvim",
    dependencies = { "Bilal2453/luvit-meta", "justinsgithub/wezterm-types" },
    ft = "lua",
    event = "LspAttach",
    opts = {
        library = {
            "../utils",
            { path = "luvit-meta/library", words = { "vim%.uv", "vim%.loop" } },
            { path = "lazy.nvim", words = { "LazyPluginSpec" } },
            { path = "wezterm-types", mods = { "wezterm" } },
        },
    },
}
