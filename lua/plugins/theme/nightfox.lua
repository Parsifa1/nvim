---@diagnostic disable: undefined-global
return {
    "EdenEast/nightfox.nvim",
    priority = 100,
    config = function()
        require("nightfox").setup {
            options = {
                transparent = not vim.g.neovide,
                modules = { cmp = { enable = true } },
                styles = {
                    comments = "italic",
                    keywords = "bold",
                    types = "italic,bold",
                },
            },
        }
    end,
}
