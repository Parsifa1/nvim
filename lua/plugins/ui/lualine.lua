local lazy_status = require "lazy.status"
local custom = require "custom"

local function readonly()
    if vim.bo.readonly then
        return ' '
    else
        return ''
    end
end

local lsp = function()
        local clients = vim.lsp.get_clients()
        local buf = vim.api.nvim_get_current_buf()
        clients = vim
            .iter(clients)
            :filter(function(client)
                return client.attached_buffers[buf]
            end)
            :filter(function(client)
                return client.name ~= "copilot"
            end)
            :map(function(client)
                return client.name
            end)
            :totable()
        local info = table.concat(clients, ", ")
        if info == "" then
            return ""
        else
            return info
        end
    end


local opts = {
    sections = {
        lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = {
            {
                'branch',
                icon = '',
            },
        },
        lualine_c = {
            {
                "filetype",
                colored = true,
                icon_only = true,
                icon = { align = "left" },
                padding = { left = 1, right = 0 },
            },
            lsp,
            {
                "diagnostics",
                symbols = {
                    error = custom.icons.diagnostic.error,
                    warn = custom.icons.diagnostic.warn,
                    info = custom.icons.diagnostic.info,
                    hint = custom.icons.diagnostic.hint,
                },
            },
            readonly,
        },
        lualine_x = {
            {
                "diff",
                symbols = {
                    added = ' ',
                    modified = '󰝤 ',
                    removed = ' ',
                },
            },
            {
                lazy_status.updates,
                cond = lazy_status.has_updates,
                color = { fg = "#ff9e64" },
            },
            {
                function()
                    local function Cwd()
                        local cwd = vim.fn.getcwd()
                        if cwd == nil then
                            return "VOID"
                        else
                            return cwd:gsub("/home/parsifa1", "~")
                        end
                    end
                    return custom.icons.ui.Folder .. " " .. Cwd()
                end,
            },
            {
                "copilot",
                show_running = true,
                symbols = {
                    status = {
                        enabled = " ",
                        disabled = " ",
                    }
                },
            },
        },
        lualine_y = {
            {
                "encoding",
                right_padding = 2,
            },

        },
        lualine_z = {
            {
                'location',
                padding = 0,
            },
            {
                function()
                    local cursorcol = vim.fn.virtcol(".")
                    if cursorcol >= 10 then
                        return " · "
                    else
                        return "· "
                    end
                end,
                padding = 0,
            },
            {
                "progress",
                separator = { right = "" },
                icon = { "󰇽", align = "left" },
                padding = { left = 0, right = 1 },
            },
        },
    },
    tabline = {
        lualine_a = {
            {
                "buffers",
                mode = 2,
                section_separators = { left = "", right = "" },
                use_mode_colors = true,
                filetype_names = {
                    TelescopePrompt = 'Telescope',
                    alpha = 'Alpha',
                    minifiles = 'Mini.Files',
                    toggleterm = 'ToggleTerm',
                    
                },
            },
        },
        lualine_z = {
            {
                "tabs",
                section_separators = { left = "", right = "" },
                use_mode_colors = true,
            },
        },
    },
    options = {
        icons_enabled = true,
        theme = "auto",
        disabled_filetypes = {
            " Alpha",
        },
        ignore_focus = {
            "Alpha",
        },
        always_divide_middle = true,
        globalstatus = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
    extensions = {
        "man",
        "quickfix",
        "neo-tree",
        "symbols-outline",
        "aerial",
        "fugitive",
        "nvim-dap-ui",
        "mundo",
        "lazy",
    },
}
--git test for no name
return {
    "nvim-lualine/lualine.nvim",
    init = function()
        vim.o.laststatus = 0
    end,
    event = "VeryLazy",
    enabled = true,
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "ofseed/lualine-copilot" },
    },
    opts = opts,
}

