local lazy_status = require "lazy.status"
local custom = require "custom"

local function modified()
    if vim.bo.modified then
        return " "
    else
        return "󰄳 "
    end
end

local function readonly()
    if vim.bo.readonly then
        return " "
    else
        return ""
    end
end

local function recording()
    local reg = vim.fn.reg_recording()
    if reg ~= "" then
        return "recording @" .. reg
    end
    reg = vim.fn.reg_recorded()
    if reg ~= "" then
        return "recorded @" .. reg
    end

    return ""
end

local function lsp()
    local clients = vim.lsp.get_clients()
    local buf = vim.api.nvim_get_current_buf()
    clients = vim.iter(clients)
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
    return info
end

local bufline = {
    lualine_a = {
        {
            "buffers",
            -- cond = function()
            --     return vim.bo.filetype ~= "alpha"
            -- end,
            mode = 2,
            section_separators = { left = "", right = "" },
            use_mode_colors = true,
            filetype_names = {
                TelescopePrompt = " Telescope",
                alpha = "󰏘 Alpha",
                minifiles = " Mini.Files",
                toggleterm = "ToggleTerm",
                checkhealth = "󰄳 Checkhelth",
                oil = " Oil",
                Outline = "󰇽 Outline",
                lazy = "󰜢 Lazy",
                Mundo = " Mundo",
                MundoDiff = " MundoDiff",
                CompetiTest = " CompetiTest",
                lspinfo = " LspInfo",
            },
            symbols = {
                modified = " ●",
                alternate_file = "",
                directory = "󰉋",
            },
        },
    },
    lualine_z = {},
}

local opts = {
    options = {
        icons_enabled = true,
        theme = "auto",
        disabled_filetypes = {
            "alpha",
            "TelescopePrompt",
            "mason",
        },
        always_divide_middle = true,
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {
            {
                modified,
                separator = { left = "", right = "" },
                padding = { left = 0, right = 0 },
            },
            {
                "mode",
                separator = { left = "", right = "" },
                padding = { left = 0, right = 0 },
            },
        },
        lualine_b = {
            {
                "branch",
                icon = "",
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
                    error = custom.icons.diagnostic.Error,
                    warn = custom.icons.diagnostic.Warning,
                    info = custom.icons.diagnostic.Information,
                    hint = custom.icons.diagnostic.Hint,
                },
            },
            readonly,
        },
        lualine_x = {
            {
                "diff",
                symbols = {
                    added = " ",
                    modified = " ",
                    removed = " ",
                },
            },
            {
                lazy_status.updates,
                cond = lazy_status.has_updates,
                color = { fg = "#ff9e64" },
            },
            recording,
            {
                "copilot",
                show_running = true,
                symbols = {
                    status = {
                        enabled = " ",
                        disabled = " ",
                    },
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
                "location",
                padding = 0,
            },
            {
                function()
                    local cursorcol = vim.fn.virtcol "."
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
    tabline = bufline,
    extensions = {
        "oil",
        "man",
        "quickfix",
        "neo-tree",
        "symbols-outline",
        "aerial",
        "fugitive",
        "nvim-dap-ui",
        "mason",
        "mundo",
        "lazy",
        "trouble",
        "toggleterm",
    },
}
return {
    "nvim-lualine/lualine.nvim",
    event = { "BufNewFile", "BufReadPre" },
    dependencies = {
        { "parsifa1/nvim-web-devicons" },
        { "ofseed/copilot-status.nvim" },
    },
    config = function()
        require("lualine").setup(opts)
    end,
}
