return {
    "altermo/ultimate-autopair.nvim",
    enabled = false,
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        require("ultimate-autopair").setup {
            tabout = {
                enable = true,
                map = "<Tab>",
                cmap = "<Tab>",
                hopout = true,
                do_nothing_if_fail = false,
            },
        }
    end,
}
