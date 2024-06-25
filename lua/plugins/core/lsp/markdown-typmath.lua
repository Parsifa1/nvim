return {
    "parsifa1/markdown-typmath.nvim",
    enabled = false,
    ft = "markdown",
    config = function()
        require("typmath").setup()
    end,
}
