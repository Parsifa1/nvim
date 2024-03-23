return {
    "b0o/incline.nvim",
    -- enabled = false,
    event = "VeryLazy",
    config = function()
        require("incline").setup {
            hide = {
                only_win = true,
            },
            window = {
                padding = 0,
                margin = {
                    horizontal = 0,
                    vertical = 0,
                },
                placement = {
                    horizontal = "right",
                    vertical = "top",
                },
            },
            render = function(props)
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                if filename == "" then
                    filename = "[No Name]"
                end
                local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
                local modified = vim.bo[props.buf].modified
                -- modified indicator
                local modified_icon = {}
                if vim.api.nvim_get_option_value("modified", { buf = props.buf }) then
                    modified_icon = vim.tbl_extend("force", { " ● " }, { guifg = ft_color })
                end
                return {
                    ft_icon and {
                        " ",
                        ft_icon,
                        " ",
                        guibg = ft_color,
                        guifg = require("incline.helpers").contrast_color(ft_color),
                    } or "",
                    " ",
                    { filename, gui = modified and "bold,italic" or "bold" },
                    modified_icon,
                    " ",
                    guibg = "#44446a",
                }
            end,
        }
    end,
}
