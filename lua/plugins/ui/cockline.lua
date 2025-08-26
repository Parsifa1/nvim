return {
    "willothy/nvim-cokeline",
    keys = {
        { "[b", "<Plug>(cokeline-focus-prev)", desc = "previous buffer" },
        { "]b", "<Plug>(cokeline-focus-next)", desc = "next buffer" },
    },
    -- event = "User AfterLoad",
    event = { "BufRead", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
        local get_hex = require("cokeline.hlgroups").get_hl_attr
        local errors_fg = get_hex("DiagnosticError", "fg")
        local warnings_fg = get_hex("DiagnosticWarn", "fg")
        local components = {
            icon = {
                text = function(buffer)
                    return " " .. buffer.devicon.icon
                end,
                fg = function(buffer)
                    return buffer.devicon.color
                end,
            },
            unique_prefix = {
                text = function(buffer)
                    return buffer.unique_prefix
                end,
                fg = get_hex("Comment", "fg"),
                italic = true,
            },
            filename = {
                text = function(buffer)
                    return buffer.filename .. " "
                end,
                underline = function(buffer)
                    return buffer.is_hovered and not buffer.is_focused
                end,
            },
            diagnostics = {
                text = function(buffer)
                    if buffer.diagnostics.errors ~= 0 then
                        return " "
                    elseif buffer.diagnostics.warnings ~= 0 then
                        return " "
                    else
                        return ""
                    end
                end,
                fg = function(buffer)
                    return (buffer.diagnostics.errors ~= 0 and errors_fg)
                        or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
                        or nil
                end,
                truncation = { priority = 1 },
            },
            close = {
                text = function(buffer)
                    if buffer.diagnostics.errors == 0 and buffer.diagnostics.warnings == 0 then
                        if buffer.is_modified then
                            return "● "
                        else
                            return " "
                        end
                    else
                        return ""
                    end
                end,
                on_click = function(_, _, _, _, buffer)
                    buffer:delete()
                end,
            },
            space = {
                text = " ",
            },
        }
        require("cokeline").setup {
            fill_hl = "TabLineNone",
            default_hl = {
                fg = function(buffer)
                    return buffer.is_focused and get_hex("TabLineFocus", "fg") or get_hex("Comment", "fg")
                end,
                bg = "NONE",
            },
            buffers = {
                filter_valid = function(buffer)
                    return buffer.type ~= "terminal" and buffer.type ~= "nofile"
                end,
            },
            components = {
                components.icon,
                components.unique_prefix,
                components.filename,
                components.diagnostics,
                components.close,
                components.space,
            },
        }
    end,
}
