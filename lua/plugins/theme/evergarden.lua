return {
  "everviolet/nvim",
  name = "evergarden",
  priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
  opts = {
    theme = {
      variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
      accent = "green",
      ansi = false,
    },
    overrides = {
      MsgArea = { bg = "NONE" },
      DiffAdd = { bg = "#344139" },
      DiffChange = { bg = "#344139" },
      DiffDelete = { bg = "#403135" },
      Underlined = { style = { "underline" } },
      Normal = { fg = "#f8f9e8", bg = "#272e32" },
    },
  },
}
