return {
    "willothy/nvim-cokeline",
    event = { "BufNewFile", "BufReadPre" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
        local get_hex = require("cokeline.hlgroups").get_hl_attr
        vim.api.nvim_set_hl(0, "TabLineNone", { bg = "NONE" })
        require("cokeline").setup {
            fill_hl = "TabLineNone",
            default_hl = {
                fg = function(buffer)
                    return buffer.is_focused and get_hex("@variable", "fg") or get_hex("Comment", "fg")
                end,
                bg = "NONE",
            },
            components = {
                {
                    text = function(buffer)
                        return " " .. buffer.devicon.icon
                    end,
                    fg = function(buffer)
                        return buffer.devicon.color
                    end,
                },
                {
                    text = function(buffer)
                        return buffer.unique_prefix
                    end,
                    fg = get_hex("Comment", "fg"),
                    italic = true,
                },
                {
                    text = function(buffer)
                        return buffer.filename .. " "
                    end,
                    underline = function(buffer)
                        return buffer.is_hovered and not buffer.is_focused
                    end,
                },
                {
                    text = "",
                    on_click = function(_, _, _, _, buffer)
                        buffer:delete()
                    end,
                },
                {
                    text = " ",
                },
            },
        }
    end,
}
