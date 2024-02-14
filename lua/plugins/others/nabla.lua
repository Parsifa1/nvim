return {
    "jbyuki/nabla.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
        require("nabla").enable_virt {
            autogen = true,
            silent = true,
        }
    end,
}
