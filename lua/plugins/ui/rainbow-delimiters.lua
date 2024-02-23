return {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufReadPre",
    config = function()
        local rainbow_delimiters = require "rainbow-delimiters"

        vim.g.rainbow_delimiters = {
            strategy = {
                [""] = rainbow_delimiters.strategy["global"],
                vim = rainbow_delimiters.strategy["local"],
            },
            query = {
                [""] = "rainbow-delimiters",
                lua = "rainbow-blocks",
            },
            highlight = {
                "TSRainbowRed",
                "TSRainbowYellow",
                "TSRainbowOrange",
                "TSRainbowBlue",
                "TSRainbowGreen",
                "TSRainbowViolet",
                "TSRainbowCyan",
                -- 'RainbowDelimiterRed',
                -- 'RainbowDelimiterYellow',
                -- 'RainbowDelimiterBlue',
                -- 'RainbowDelimiterOrange',
                -- 'RainbowDelimiterGreen',
                -- 'RainbowDelimiterViolet',
                -- 'RainbowDelimiterCyan',
            },
        }
    end,
}
