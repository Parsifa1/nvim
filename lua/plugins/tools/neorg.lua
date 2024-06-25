---@type LazyPluginSpec

return {
    "nvim-neorg/neorg",
    ft = "norg",
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {
                config = { icons = { todo = false } },
            },
            ["core.keybinds"] = {
                config = {
                    -- hook = function(keybinds)
                    --     -- keybinds.remap_event("norg", "n", "<leader>nt", "core.qol.todo_items.todo.task_done")
                    -- end,
                },
            },
        },
    },
}
