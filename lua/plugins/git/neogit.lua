local custom = require "custom"

return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "rcarriga/nvim-notify",
    },
    cmd = "Neogit",
    keys = {
        { "<leader>gg", "<cmd>Neogit<CR>", desc = "open neogit" },
    },
    opts = {
        disable_insert_on_commit = false,
        disable_commit_confirmation = true,
        disable_builtin_notifications = true,
        kind = custom.prefer_tabpage and "tab" or "split",
        integrations = { diffview = true },
        commit_editor = { kind = "split" },
        sections = {
            stashes = { folded = false },
            recent = { folded = false },
        },
    },
}
