return {
    "folke/noice.nvim",
    event = "User AfterLoad",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
        { "<leader>n", "<cmd>NoiceAll<CR>", desc = "open Noice" },
    },
    opts = {
        cmdline = { view = "cmdline" },
        views = {
            confirm = {
                position = { row = "50%" },
            },
            hover = { scrollbar = false },
            split = { scrollbar = false },
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = false,
            },
            hover = { enabled = true, silent = true },
            progress = { enabled = false },
            signature = { enabled = false },
        },
        presets = {
            lsp_doc_border = true,
            long_message_to_split = true,
            bottom_search = true,
            command_palette = false,
        },
        routes = {
            {
                view = "split",
                filter = { event = "msg_show", min_height = 20 },
            },
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "W10" },
                        { find = "E21" },
                        -- { find = "E492" },
                        -- { find = "E486" },
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                        { find = "%d fewer lines" },
                        { find = "%d more lines" },
                        { find = "Index out of bounds" },
                        { find = "deprecated" },
                    },
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "notify",
                    any = {
                        { find = "position_encoding" },
                        { find = "Delete existing terminal" },
                        { find = "No matching notification found to replace" },
                    },
                },
                opts = { skip = true },
            },
        },
    },
}
