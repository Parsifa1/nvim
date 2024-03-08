return {
    "kylechui/nvim-surround",
    event = { "BufNewFile", "BufReadPost" },
    config = function()
        require("nvim-surround").setup {
            -- Configuration here, or leave empty to use defaults
        }
    end,
}
