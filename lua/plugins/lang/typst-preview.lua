---@type LazyPluginSpec
---@diagnostic disable: unused-local

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
