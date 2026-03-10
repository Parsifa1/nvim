return {
  "folke/sidekick.nvim",
  event = "User AfterFile",
  keys = {
    { "<leader>as", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle CLI" },
  },
  opts = {
    nes = { enabled = false },
    cli = {
      mux = { backend = "tmux", enabled = true },
      win = {
        split = { width = 0.4 },
      },
      tools = {
        codex = { cmd = { "codex" } },
        omp = { cmd = { "omp" } },
      },
    },
  },
}
