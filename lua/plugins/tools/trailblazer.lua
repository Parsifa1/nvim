return {
    "LeonHeidelbach/trailblazer.nvim",
    event = "User AfterLoad",
    config = function()
        require("trailblazer").setup {
            -- your custom config goes here
            force_mappings = { -- rename this to "force_mappings" to completely override default mappings and not merge with them
                nv = { -- Mode union: normal & visual mode. Can be extended by adding i, x, ...
                    motions = {
                        new_trail_mark = "m",
                        track_back = "'",
                    },
                    actions = {},
                },
            },
        }
    end,
}
