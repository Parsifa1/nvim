return {
    "folke/noice.nvim",
    event = { "BufNewFile", "BufReadPre" },
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    keys = {
        { "<leader>n", "<cmd>Noice<CR>", desc = "open Noice" },
    },
    opts = {
        cmdline = { view = "cmdline" },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            progress = { enabled = false },
            hover = { enabled = true },
            signature = { enabled = true },
        },
        views = {
            hover = {
                scrollbar = false,
            },
            confirm = {
                position = { row = "50%" },
            },
        },
        presets = {
            lsp_doc_border = true,
            long_message_to_split = true,
            bottom_search = true,
            command_palette = true,
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                        { find = "%d fewer lines" },
                        { find = "%d more lines" },
                    },
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "E21",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "clipboard",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "W10",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "notify",
                    find = "Delete existing terminal",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "notify",
                    find = "telescope.builtin.buffers",
                },
                opts = { skip = true },
            },
        },
    },
}
