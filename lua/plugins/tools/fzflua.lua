local ivy = {
    previewers = { builtin = { toggle_behavior = "extend" } },
    fzf_opts = { ["--layout"] = "reverse", ["--marker"] = "+" },
    header = false,
    winopts = {
        height = 25,
        width = 1,
        row = 1,
        backdrop = false,
        preview = {
            scrollbar = false,
            hidden = "nohidden",
            layout = "flex",
            horizontal = "right:50%",
            flip_columns = 120,
        },
    },
    hls = {
        normal = "TelescopeNormal",
        border = "TelescopeBorder",
        title = "TelescopePromptTitle",
        help_normal = "TelescopeNormal",
        help_border = "TelescopeBorder",
        preview_normal = "TelescopeNormal",
        preview_border = "TelescopeBorder",
        preview_title = "TelescopePreviewTitle",
        cursor = "Cursor",
        cursorline = "TelescopeSelection",
        cursorlinenr = "TelescopeSelection",
        search = "IncSearch",
    },
}

return {
    "ibhagwan/fzf-lua",
    enabled = true,
    keys = {
        { "<leader>f", "<cmd>FzfLua files<CR>", desc = "open files" },
        { "<leader>r", "<cmd>FzfLua oldfiles<CR>", desc = "recent files" },
        { "<esc>", "<c-c>", ft = "fzf", mode = "t", nowait = true },
    },
    cmd = "FzfLua",
    opts = {
        { "default-title" },
        winopts = { backdrop = false },
        files = ivy,
        oldfiles = ivy,
    },
}
