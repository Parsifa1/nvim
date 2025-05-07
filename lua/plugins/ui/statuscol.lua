return {
    "luukvbaal/statuscol.nvim",
    event = "User AfterLoad",
    init = function()
        vim.o.statuscolumn = "%{%v:lua.require('statuscol').get_statuscol_string()%}"
    end,
    opts = function()
        local builtin = require "statuscol.builtin"
        return {
            bt_ignore = { "quickfix", "prompt", "terminal" },
            ft_ignore = { "leetcode.nvim", "help" },
            segments = {
                { -- TODO:调整colwidth
                    sign = {
                        name = { ".*" },
                        text = { ".*" },
                        colwidth = 2,
                        wrap = false,
                    },
                },
                {
                    text = { builtin.lnumfunc },
                    condition = { true, builtin.not_empty },
                    click = "v:lua.ScLa",
                },
                {
                    sign = { namespace = { "gitsigns" }, colwidth = 1, wrap = true },
                    click = "v:lua.ScSa",
                },
                { text = { " " } },
                {
                    text = {
                        function(args)
                            args.fold.close = ""
                            args.fold.open = ""
                            args.fold.sep = " "
                            return builtin.foldfunc(args)
                        end,
                    },
                    click = "v:lua.ScFa",
                },
                { text = { " " } },
            },
        }
    end,
}
