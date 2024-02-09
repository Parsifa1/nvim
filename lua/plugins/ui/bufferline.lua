return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
        require("bufferline").setup {
            options = {
                buffer_close_icon = "󰅙 ",
                separator_style = { "", "" },
                 tab_size = 12,
                 diagnostics = 'nvim_lsp',
                style_preset = require("bufferline").style_preset.mininal,
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { "close" },
                },
            },
        }
    end,
}
