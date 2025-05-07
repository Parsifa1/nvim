---@type LazyPluginSpec

return {
    {
        "mrcjkb/rustaceanvim",
        version = "*", -- Recommended
        ft = { "rust" },
        config = function()
            vim.g.rustaceanvim = {
                tools = {
                    float_win_config = {
                        border = "rounded",
                    },
                    test_executor = "background",
                },
            }
        end,
    },
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        tag = "stable",
        config = function()
            ---@diagnostic disable-next-line: missing-parameter
            require("crates").setup()
        end,
    },
}
