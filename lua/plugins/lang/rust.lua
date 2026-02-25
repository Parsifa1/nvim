---@type LazyPluginSpec

return {
  {
    "mrcjkb/rustaceanvim",
    version = "*", -- Recommended
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          float_win_config = {
            border = "rounded",
          },
          test_executor = "background",
        },
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              files = {
                excludeDirs = { ".direnv", ".git", "target" },
              },
              semanticHighlighting = {
                strings = { enable = false },
              },
            },
          },
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    tag = "stable",
    config = function()
      require("crates").setup {
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
        popup = { border = "rounded" },
      }
    end,
  },
}
