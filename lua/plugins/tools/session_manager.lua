---@type LazyPluginSpec[]
return {
  {
    "Shatur/neovim-session-manager",
    keys = {
      { "<leader><Tab>", "<cmd>SessionManager load_session<CR><esc>", desc = "Session Picker" },
      { "<leader>i", "<cmd>SessionManager load_session<CR><esc>", desc = "Session Picker" },
    },
    lazy = false,
    config = function()
      local config = require "session_manager.config"
      require("session_manager").setup {
        autoload_mode = { config.AutoloadMode.GitSession, config.AutoloadMode.CurrentDir },
        autosave_ignore_filetypes = { "gitcommit", "gitrebase", "toggleterm", "help", "lazy", "codecompanion" },
        autosave_ignore_buftypes = { "terminal" },
        autosave_only_in_session = true,
      }
    end,
  },
}
