return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
        require("bufferline").setup {
            options = {
                mode = "buffers",
                style_preset = {
                    -- require("bufferline").style_preset.no_italic,
                    require("bufferline").style_preset.minimal,
                },
                diagnostics = "nvim_lsp",
                max_name_length = 15,
                tab_size = 15,
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_duplicate_prefix = false,
                show_tab_indicators = false,
                separator_style = { "", "" },
                hover = {
                    enabled = true,
                    delay = 0,
                    reveal = { "close" },
                },
            },
            highlights = {
                indicator_selected = {
                    fg = "#81a1c1",
                },
                tab_selected = {
                    bg = "#81a1c1",
                },
            },
        }
    end,
}
