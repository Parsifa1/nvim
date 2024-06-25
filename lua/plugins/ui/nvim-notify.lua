return {
    "rcarriga/nvim-notify",
    lazy = true,
    -- event = "VeryLazy",
    init = function()
        vim.notify = function(...)
            if not require("lazy.core.config").plugins["nvim-notify"]._.loaded then
                require("lazy").load { plugins = "nvim-notify" }
            end
            require "notify"(...)
        end
    end,
    config = function()
        require("notify").setup {
            stages = "static",
            render = "minimal",
            background_colour = "Normal",
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { focusable = false })
            end,
            -- top_down = false,
        }
    end,
}
