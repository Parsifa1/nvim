return {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
        require("neoscroll").setup {
            respect_scrolloff = true,
            pre_hook = function()
                vim.opt.eventignore:append {
                    "WinScrolled",
                    "CursorMoved",
                }
            end,
            post_hook = function()
                vim.opt.eventignore:remove {
                    "WinScrolled",
                    "CursorMoved",
                }
            end,
        }
    end,
}
