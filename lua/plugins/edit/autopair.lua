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
    },
}
