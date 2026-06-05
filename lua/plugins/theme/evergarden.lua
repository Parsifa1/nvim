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
      DiffAdd = { bg = "#3c4841" },
      DiffChange = { bg = "#384b55" },
      DiffDelete = { bg = "#493b40" },
      Normal = { fg = "#f8f9e8", bg = "#272e32" },
    },
  },
}
