return {
    "Bekaboo/dropbar.nvim",
    -- enabled = false,
    event = "BufReadPre",
    opts = {
        general = {
            enable = function(buf, win)
                ---@diagnostic disable-next-line: undefined-field
                return not vim.api.nvim_win_get_config(win).zindex
                    and vim.bo[buf].buftype == ""
                    and vim.api.nvim_buf_get_name(buf) ~= ""
                    and not vim.wo[win].diff
                    and vim.bo[buf].filetype ~= "toggleterm"
            end,
        },
    },
}
