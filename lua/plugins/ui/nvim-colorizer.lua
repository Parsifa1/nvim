return {
    "NvChad/nvim-colorizer.lua",
    ft = {
        "html",
        "css",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "lua",
        "fish",
    },
    config = function()
        require("colorizer").setup {}
    end,
}
