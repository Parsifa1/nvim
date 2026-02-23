local custom = require "config.custom"
local keymap = require "config.keymap"
---@type wk.Opts
local opts = {
  show_help = false,
  win = { border = custom.border, no_overlap = false },
  plugins = { presets = { z = true } },
  defer = function(ctx) return ctx.keys == "`" or ctx.mode == "V" or ctx.mode == "<C-V>" or ctx.mode == "v" end,
  icons = {
    rules = {
      { pattern = "go", icon = "󰇐 ", color = "blue" },
      { pattern = "dap", icon = "󱋆 ", color = "grey" },
      { pattern = "end", icon = "󰘁 ", color = "green" },
      { pattern = "case", icon = "󱥖 ", color = "red" },
      { pattern = "fold", icon = " ", color = "cyan" },
      { pattern = "last", icon = "󰘁 ", color = "green" },
      { pattern = "undo", icon = " ", color = "green" },
      { pattern = "open", icon = "󰠜 ", color = "cyan" },
      { pattern = "line", icon = "󰘁 ", color = "green" },
      { pattern = "spell", icon = " ", color = "red" },
      { pattern = "close", icon = "󰠛 ", color = "red" },
      { pattern = "chore", icon = " ", color = "cyan" },
      { pattern = "cycle", icon = "󰤁 ", color = "orange" },
      { pattern = "delete", icon = "󰆴 ", color = "red" },
      { pattern = "kurara", icon = "󰖟 ", color = "orange" },
      { pattern = "outline", icon = "󰵅 ", color = "blue" },
    },
  },
}

return {
  "folke/which-key.nvim",
  event = "User AfterFile",
  config = function()
    require("which-key").setup(opts)
    require("which-key").add {
      keymap,
      { "<leader>a", group = "AI Slop" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code Operations" },
      { "<leader>d", group = "Dap" },
      { "<leader>g", group = "Git" },
      { "<leader>R", group = "Kurara" },
      { "<leader>s", group = "Chore" },
      { "<leader>t", group = "Telescope" },
      { "gx", "Open Link or File", icon = "󰖟 " },
      {
        "<leader><space>",
        function() require("which-key").show { keys = "<leader>", loop = true, delay = "65535" } end,
        hidden = true,
      },
    }
  end,
}
