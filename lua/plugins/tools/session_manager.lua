---@type LazyPluginSpec[]
return {
  {
    "parsifa1/neovim-session-manager",
    branch = "resession-backend",
    -- dir = "~/desktop/project/neovim-session-manager",
    dependencies = { "stevearc/dressing.nvim" },
    keys = {
      { "<leader><Tab>", "<cmd>SessionManager load_session<CR><esc>", desc = "Session Picker" },
      { "<leader>i", "<cmd>SessionManager load_session<CR><esc>", desc = "Session Picker" },
    },
    lazy = false,
    config = function()
      local config = require "session_manager.config"
      require("session_manager").setup {
        resession_backend = true,
        autoload_mode = { config.AutoloadMode.GitSession, config.AutoloadMode.CurrentDir },
        autosave_ignore_filetypes = { "gitcommit", "gitrebase", "toggleterm", "help", "lazy", "codecompanion" },
        autosave_ignore_buftypes = { "terminal" },
        autosave_only_in_session = true,
      }
    end,
  },
  {
    "parsifa1/resession.nvim",
    branch = "fix-separator",
    event = "User AfterFile",
    opts = {},
  },
}
