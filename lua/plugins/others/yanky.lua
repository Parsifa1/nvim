return {
    "gbprod/yanky.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
        { "kkharji/sqlite.lua" }
    },
    opts = {
        ring = { storage = "sqlite" },
    },
}
