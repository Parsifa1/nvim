return {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    config = function()
        require("nvim-surround").setup {
            -- Configuration here, or leave empty to use defaults
        }
    end,
}
