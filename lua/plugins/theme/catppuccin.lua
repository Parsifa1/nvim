return {
  "catppuccin/nvim",
  enabled = false,
  name = "catppuccin",
  lazy = true,
  opts = {
    flavour = "macchiato",
    -- transparent_background = not vim.g.neovide,
    term_colors = true,
    integrations = {
      aerial = true,
      fidget = true,
      markdown = true,
      mason = true,
      neotree = true,
      native_lsp = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = {
        enabled = true,
      },
      noice = true,
      notify = true,
      octo = true,
      overseer = true,
      symbols_outline = true,
      illuminate = true,
      ufo = false,
      which_key = true,
    },
  },
}
