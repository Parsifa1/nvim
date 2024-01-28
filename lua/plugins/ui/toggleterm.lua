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
        shell = vim.uv.os_uname().sysname == "bash" or "fish",
        float_opts = {
            border = "double",
        },
        persist_mode = false,
        start_in_insert = true,
        autochdir = false,
    },
    keys = {
        { "<C-\\>" },
        { "<Esc>", "<C-\\><C-N>", mode = "t" },
        {
            "<leader>gl",
            function()
                require("toggleterm.terminal").Terminal
                    :new({
                        cmd = "lazygit",
                        hidden = true,
                        direction = "float",
                    })
                    :toggle()
            end,
            desc = "LazyGit",
        },
    },
}
