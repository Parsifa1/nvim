return {
  "folke/sidekick.nvim",
  dependencies = "stevearc/dressing.nvim",
  event = "User AfterFile",
  keys = {
    { "<leader>as", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle CLI" },
  },
  opts = {
    nes = { enabled = false },
    cli = {
      mux = { backend = "zellij", enabled = true },
      win = {
        split = { width = 0.45 },
      },
      tools = {
        codex = { cmd = { "codex" } },
        omp = { cmd = { "omp" } },
      },
    },
  },
}
