return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
        flavour = "mocha",
        transparent_background = not vim.g.neovide,
        term_colors = true,
        custom_highlights = function(color)
            return {
                TabLine = { bg = color.surface0, fg = color.subtext0 },
                TabLineFill = { fg = color.subtext0, bg = color.mantle },
                TabLineSel = { fg = color.base, bg = color.overlay1 },
                MatchParen = { fg = "NONE", bg = color.surface1, style = { "bold" } },
                NormalFloat = { fg = color.subtext0, bg = "NONE" },
            }
        end,
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
    }
}
