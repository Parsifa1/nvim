local lazy_status = require "lazy.status"

local function indent()
    if vim.o.expandtab then
        return "SW:" .. vim.o.shiftwidth
    else
        return "TS:" .. vim.o.tabstop
    end
end

local function lsp()
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
        return "No attached LSP server"
    else
        return info
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

local opts = {
    sections = {
        lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
        lualine_c = {
            lsp,
        },
        lualine_x = {
            recording,
            {
                lazy_status.updates,
                cond = lazy_status.has_updates,
                color = { fg = "#ff9e64" },
            },
            "overseer",
            "copilot",
            indent,
            "encoding",
            "fileformat",
        },
        lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
    },
    tabline = {  -- If you want tabline to shift too
        lualine_a = { "buffers" },
        lualine_z = {'tabs'}
    },
    options = {
        icons_enabled = true,
        theme = "auto",
        disabled_filetypes = {
            'alpha',
        },
        always_divide_middle = true,
        globalstatus = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
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
     inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
}

return {
    'nvim-lualine/lualine.nvim',
    init = function()
        vim.o.laststatus = 0
    end,
    enable = false,
    -- event = "VeryLazy",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "ofseed/lualine-copilot" },
    },
    opts = opts
}
