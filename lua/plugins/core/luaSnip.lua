return {
    'L3MON4D3/LuaSnip',
    build = "make install_jsregexp",
    event = {
        "InsertEnter",
        "CmdlineEnter",
    },
    config = function ()
        local snip = require "luasnip"
        local i = snip.insert_node
        local sn = snip.snippet_node
        require("luasnip").config.setup({
            enable_autosnippets = true
        })
        require("luasnip.loaders.from_lua").lazy_load {
            paths = vim.fn.stdpath "config" .. "/lua/snippets",
        }
    end
}
