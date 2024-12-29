---@diagnostic disable: duplicate-set-field
---@type LazyPluginSpec
return {
    -- FIX: temp fix wrapped-compact error
    "parsifa1/nvim-notify",
    lazy = true,
    init = function()
        vim.notify = function(...)
            if not require("lazy.core.config").plugins["nvim-notify"]._.loaded then
                require("lazy").load { "nvim-notify" }
            end
            require "notify"(...)
        end
    end,
    config = function()
        require("notify").setup {
            stages = "fade",
            render = "wrapped-compact",
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { focusable = false })
            end,
            -- top_down = false,
        }
    end,
}
