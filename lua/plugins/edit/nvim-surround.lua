return {
    "kylechui/nvim-surround",
    event = "User AfterLoad",
    config = function()
        require("nvim-surround").setup {
            -- Configuration here, or leave empty to use defaults
        }
    end,
}
