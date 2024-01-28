local custom = require "custom"
local float_opts = {
    border = custom.border,
}
return {
    "akinsho/nvim-toggleterm.lua",
    enabled = true,
    event = "VeryLazy",
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 16
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
        direction = "horizontal",
        open_mapping = [[<c-\>]],
        on_create = function(t)
            local bufnr = t.bufnr
            vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { buffer = bufnr })
        end,
        shell = vim.uv.os_uname().sysname == "bash" or "fish",
        float_opts = float_opts,
        start_in_insert = true,
        autochdir = false,
    },
    keys = {

        { "<C-\\>" },
        {
            "<leader>gl",
            function()
                require("toggleterm.terminal").Terminal
                    :new({
                        cmd = "lazygit",
                        hidden = true,
                        float_opts = float_opts,
                        direction = "float",
                    })
                    :toggle()
            end,
            desc = "LazyGit",
        },
        {
            "<leader>gf",
            function()
                require("toggleterm.terminal").Terminal
                    :new({
                        cmd = "joshuto",
                        hidden = true,
                        float_opts = float_opts,
                        direction = "float",
                    })
                    :toggle()
            end,
            desc = "Joshuto",
        },
    },
}
