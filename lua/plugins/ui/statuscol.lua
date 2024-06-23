return {
    "luukvbaal/statuscol.nvim",
    event = { "BufNewFile", "BufReadPre" },
    opts = function()
        local builtin = require "statuscol.builtin"

        return {
            bt_ignore = { "nofile", "terminal" },
            ft_ignore = { "leetcode.nvim" },
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
                },
                {
                    sign = { namespace = { "gitsigns" }, colwidth = 1, wrap = true },
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
                },
                { text = { " " } },
            },
        }
    end,
}
