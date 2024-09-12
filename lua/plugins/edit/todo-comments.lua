return {
    "folke/todo-comments.nvim",
    event = "User AfterLoad",
    config = function()
        require("todo-comments").setup {
            signs = true,
        }
    end,
    --BUG: do not have SIGNS
}
