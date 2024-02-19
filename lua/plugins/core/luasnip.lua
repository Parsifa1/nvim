return {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "TwIStOy/luasnip-snippets",
        "nvim-treesitter/nvim-treesitter",
    },
    event = {
        "BufReadPost",
        "CmdlineEnter",
    },
    config = function()
        require("luasnip").config.setup {
            enable_autosnippets = true,
        }
        require("luasnip.loaders.from_lua").lazy_load {
            ---@diagnostic disable-next-line: assign-type-mismatch
            paths = vim.fn.stdpath "config" .. "/lua/snippets",
        }
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip-snippets").setup()
    end,
}
