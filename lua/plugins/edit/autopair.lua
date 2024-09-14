return {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
        tabout = {
            enable = false,
            map = "<Tab>",
            cmap = "<Tab>",
            hopout = true,
            do_nothing_if_fail = false,
        },
        config_internal_pairs = {
            {
                "'",
                "'",
                multiline = false,
                surround = true,
                cond = function(fn)
                    if
                        fn.get_ft() ~= "rust"
                        and not fn.in_node { "bounded_type", "reference_type", "type_arguments", "type_parameters" }
                    then
                        return true
                    end
                end,
            },
        },
    },
}
