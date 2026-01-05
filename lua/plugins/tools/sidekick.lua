return {
  "folke/sidekick.nvim",
  event = "User AfterFile",
  keys = {
    {
      "<tab>",
      function()
        if not require("sidekick").nes_jump_or_apply() then return "<tab>" end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
  },
  opts = {
    nes = { enabled = false },
    cli = { mux = { backend = "tmux", enabled = true } },
  },
}
