-- local custom = require "custom"

return {
    "Parsifa1/dropbar.nvim",
    dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' },
    event = "VeryLazy",
    opts = {
        general = {
            enable = function(buf, win)
                return not vim.api.nvim_win_get_config(win).zindex
                    and vim.bo[buf].buftype == ""
                    and vim.api.nvim_buf_get_name(buf) ~= ""
                    and not vim.wo[win].diff
                    and vim.bo[buf].filetype ~= "toggleterm"
            end,
        },
    },
}

