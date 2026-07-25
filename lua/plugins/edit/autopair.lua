---@diagnostic disable: undefined-field
return {
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {},
  },
  {
    "saghen/blink.pairs",
    event = "User AfterFile",
    dependencies = "saghen/blink.lib",
    build = function() require("blink.pairs").download():pwait(1000) end,
    version = "*",
    opts = {
      mappings = { enabled = false },
      highlights = {
        groups = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      },
    },
  },
}
