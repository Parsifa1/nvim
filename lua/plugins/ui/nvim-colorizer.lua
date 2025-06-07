local ft = {
    "html",
    "css",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "lua",
    "yaml",
    "toml",
    "fish",
}

---@type LazyPluginSpec
return {
    "NvChad/nvim-colorizer.lua",
    ft = ft,
    config = function()
        require("colorizer").setup {
            filetypes = ft,
            user_default_options = {
                virtualtext = "󱓻 ",
                virtualtext_inline = true,
                mode = "virtualtext",
            },
        }
    end,
}
