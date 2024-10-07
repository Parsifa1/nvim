return {
    "3rd/image.nvim",
    enabled = false,
    ft = "markdown",
    config = function()
        require("image").setup {
            backend = "kitty",
        }
    end,
}
