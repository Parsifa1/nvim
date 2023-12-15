return {
    'L3MON4D3/LuaSnip',
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = {
        "InsertEnter",
        "CmdlineEnter",
    },
    config = function()
        local snip = require "luasnip"
        local i = snip.insert_node
        local sn = snip.snippet_node
        require("luasnip").config.setup({
            enable_autosnippets = true
        })
        require("luasnip.loaders.from_lua").lazy_load {
            ---@diagnostic disable-next-line: assign-type-mismatch
            paths = vim.fn.stdpath "config" .. "/lua/snippets",
        }
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}

