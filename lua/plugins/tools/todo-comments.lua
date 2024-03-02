return {
    "folke/todo-comments.nvim",
    version = "*",
    event = "BufReadPost",
    config = function()
        require("todo-comments").setup {
            signs = true,
        }
    end,
    --BUG: do not have SIGNS
}
