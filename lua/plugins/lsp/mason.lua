return {
  {
    "mason-org/mason.nvim",
    keys = {
      { "<leader>m", "<cmd>Mason<CR>", desc = "open Mason" },
    },
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonUpdate",
    },
    config = function()
      require("mason").setup {
        PATH = "skip", -- NOTE:为了兼容NIXOS
        registries = { "github:mason-org/mason-registry" },
        ui = {
          backdrop = 100,
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }
      if not vim.env.PATH:find "mason" then
        local sep = (require "utils.function").is_windows() and ";" or ":"
        vim.env.PATH = vim.env.PATH .. sep .. vim.env.MASON .. "/bin"
      end
    end,
  },
}
