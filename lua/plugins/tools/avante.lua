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
    cmd = { "AvanteAsk", "AvanteEdit", "AvanteRefresh" },
    build = build(),
    opts = {
        provider = "copilot",
        copilot = {
            model = "claude-3.7-sonnet",
        },
        hints = { enabled = false },
        windows = {
            input = { prefix = "❯ " },
            edit = { border = "rounded" },
        },
        mappings = {
            sidebar = {
                close_from_input = { normal = "<Esc>", insert = "<C-d>" },
            },
        },
    },
    keys = {
        { "<leader>aa", "<Plug>(AvanteAsk)", desc = "avante: ask", mode = { "n", "v" } },
        { "<leader>ar", "<Plug>(AvanteRefresh)", desc = "avante: refresh" },
        { "<leader>ae", "<Plug>(AvanteEdit)", desc = "avante: edit", mode = "v" },
    },
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "echasnovski/mini.icons",
        "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
}
