local build = function()
    if vim.uv.os_uname().sysname == "Windows_NT" then
        return "powershell -File Build.ps1"
    else
        return "make"
    end
end

return {
    "yetone/avante.nvim",
    -- commit = "a60a8d4",
    build = build(),
    opts = {
        provider = "copilot",
        copilot = {
            model = "claude-3.7-sonnet",
        },
        hints = { enabled = false },
        windows = {
            input = { prefix = "❯ " },
        },
    },
    keys = {
        {
            "<leader>aa",
            function()
                require("avante.api").ask()
            end,
            desc = "avante: ask",
            mode = { "n", "v" },
        },
        {
            "<leader>ar",
            function()
                require("avante.api").refresh()
            end,
            desc = "avante: refresh",
        },
        {
            "<leader>ae",
            function()
                require("avante.api").edit()
            end,
            desc = "avante: edit",
            mode = "v",
        },
    },
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "echasnovski/mini.icons",
        "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
}
