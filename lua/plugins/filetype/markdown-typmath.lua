return {
    "parsifa1/markdown-typmath.nvim",
    ft = "markdown",
    config = function()
        require("typmath").setup()
    end,
}
