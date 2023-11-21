return {
    "folke/todo-comments.nvim",
    version = "*",
    -- dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
        require("todo-comments").setup({
            signs = true,          -- show icons in the signs column
        })
    end
--BUG do not have SIGNS
}
