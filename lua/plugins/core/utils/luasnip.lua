---@diagnostic disable: assign-type-mismatch
return {
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "nvim-treesitter/nvim-treesitter",
        },
        event = { "BufNewFile", "BufReadPost" },
        config = function()
            require("luasnip").config.setup {
                enable_autosnippets = true,
            }
            require("luasnip.loaders.from_lua").lazy_load {
                paths = vim.fn.stdpath "config" .. "/lua/snippets",
            }
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "TwIStOy/luasnip-snippets",
        event = { "BufNewFile", "BufReadPost" },
        dependencies = { "L3MON4D3/LuaSnip" },
        opts = {
            disable_auto_expansion = {
                cpp = { "i32", "i64" },
            },
        },
    },
}
