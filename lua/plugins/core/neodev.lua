return {
    "folke/neodev.nvim",
    event = "VeryLazy",
    opts = {
        override = function(root_and_library)
            local library = root_and_library.roo_dir
            library.enabled = true
            library.plugins = true
        end,

    }
}

