return {
  "everviolet/nvim",
  name = "evergarden",
  priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
  opts = {
    theme = {
      variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
      accent = "green",
    },
    overrides = {
      MsgArea = { bg = "NONE" },
      DiffAdd = { bg = "#3c4841" },
      DiffChange = { bg = "#384b55" },
      DiffDelete = { bg = "#493b40" },
    },
  },
}
