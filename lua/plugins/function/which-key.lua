return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 600
    end,
    opts = {
        -- your configuration comes here
        plugins = {
            presets = {
                windows = false,
                z = false,
                g = false
            }
        }
    }
}
