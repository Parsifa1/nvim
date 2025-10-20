---@diagnostic disable: unused-local
---@type LazyPluginSpec

return {
  "folke/edgy.nvim",
  enabled = true,
  event = "User AfterFile",
  opts = {
    animate = { enabled = false },
    bottom = {
      "Trouble",
      { ft = "qf", title = "QuickFix" },
      {
        ft = "help",
        size = { height = 20 },
        filter = function(buf) return vim.bo[buf].buftype == "help" end,
      },
      {
        ft = "noice",
        size = { height = 0.4 },
        filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == "" end,
      },
    },
    left = {
      { ft = "Mundo", size = { width = 0.4 } },
      { ft = "MundoDiff", size = { width = 0.4 } },
    },
    right = {
      {
        ft = "Outline",
        pinned = true,
        open = "Outline",
        size = { width = 0.3 },
      },
    },
    exit_when_last = true,
  },
}
