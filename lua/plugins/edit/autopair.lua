return {
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {},
  },
  {
    "saghen/blink.pairs",
    event = "User AfterFile",
    dependencies = "saghen/blink.download",
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
