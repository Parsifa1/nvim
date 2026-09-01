local fn = require "config.custom"

---@type LazyPluginSpec
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  enabled = not fn.is_server(),
  build = ":Copilot auth",
  event = { "InsertEnter", "User AfterFile" },
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      keymap = {
        accept = "<C-CR>",
        next = "<C-'>",
        prev = "<C-;>",
        dismiss = "<C-BS>",
      },
    },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}
