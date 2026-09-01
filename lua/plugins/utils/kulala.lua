local fn = require "config.custom"

--- @type LazyPluginSpec
return {
  "mistweaverco/kulala.nvim",
  enabled = not fn.is_server(),
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = true,
  },
}
