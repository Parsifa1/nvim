return {
    "jbyuki/nabla.nvim",
    event = "VeryLazy",
    config = function()
        require("nabla").enable_virt {
            autogen = true,
            silent = true,
        }
    end,
}
