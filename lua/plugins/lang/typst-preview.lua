---@type LazyPluginSpec
---@diagnostic disable: unused-local
local is_wsl = require("config.custom").is_wsl

return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  opts = {
    debug = false,
    dependencies_bin = {
      ["tinymist"] = "tinymist",
      ["websocat"] = "websocat",
    },
  },
}
