local build = function()
    if vim.uv.os_uname().sysname == "Windows_NT" then
        return "powershell -File Build.ps1"
    else
        return "make"
    end
end
return {
    "yetone/avante.nvim",
    build = build(),
    opts = {
        provider = "copilot",
        copilot = {
            model = "claude-3.5-sonnet",
        },
        hints = { enabled = false },
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
