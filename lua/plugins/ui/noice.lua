return {
    "folke/noice.nvim",
    event = "User AfterLoad",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    keys = {
        { "<leader>n", "<cmd>NoiceAll<CR>", desc = "open Noice" },
    },
    opts = {
        cmdline = { view = "cmdline" },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = false,
            },
            progress = { enabled = false },
            signature = { enabled = false },
            hover = {
                enabled = true,
                silent = true,
            },
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
                    any = {
                        { find = "W10" },
                        { find = "E21" },
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
                        { find = "telescope.builtin.buffers" },
                        { find = "No matching notification found to replace" },
                    },
                },
                opts = { skip = true },
            },
        },
    },
}
