local build = function()
    return vim.uv.os_uname().sysname == "Windows_NT" and "powershell -File Build.ps1" or "make"
end

return {
    "yetone/avante.nvim",
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
        behaviour = {
            enable_claude_text_editor_tool_mode = true,
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
