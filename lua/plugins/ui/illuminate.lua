return {
    "ofseed/vim-illuminate",
    event = { "User AfterLoad" },
    config = function()
        local opts = {
            providers = { "lsp", "treesitter" },
        }
        require("illuminate").configure(opts)
    end,
}
