local custom = require "custom"

return {
    "akinsho/toggleterm.nvim",
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 16
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
        open_mapping = [[<c-\>]],
        on_create = function(t)
            local bufnr = t.bufnr
            vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { buffer = bufnr })
        end,
        ---@diagnostic disable-next-line: undefined-field
        shell = vim.uv.os_uname().sysname == "Windows_NT" and "pwsh" or "fish",
        float_opts = {
            border = custom.border,
        },
    },

    keys = function()
        local float_opts = {
            border = custom.border,
        }

        local lazygit = require("toggleterm.terminal").Terminal:new {
            cmd = "lazygit",
            hidden = true,
            direction = "float",
            float_opts = float_opts,
        }
        local yazi = require("toggleterm.terminal").Terminal:new {
            cmd = "yazi",
            hidden = true,
            direction = "float",
            float_opts = float_opts,
        }

        return {
            { "<C-\\>" },
            { "`", "<cmd>ToggleTerm<CR>", mode = { "n", "t" }, desc = "Terminal" },
            {
                "`",
                function()
                    vim.cmd "ToggleTerm"
                    if vim.fn.mode() == "n" then
                        vim.cmd "startinsert"
                    end
                end,
                mode = "t",
                desc = "Terminal",
            },

            -- External programs
            {
                "<leader>gl",
                function()
                    lazygit:toggle()
                end,
                desc = "LazyGit",
            },
            {
                "<leader>gf",
                function()
                    yazi:toggle()
                end,
                desc = "Yazi",
            },
        }
    end,
}
