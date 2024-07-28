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

local merge = function(x)
    return vim.tbl_extend("force", ivy, x)
end

return {
    "ibhagwan/fzf-lua",
    enabled = true,
    keys = {
        { "<leader>f", "<cmd>FzfLua files<CR>", desc = "open files" },
        { "<leader>r", "<cmd>FzfLua oldfiles<CR>", desc = "recent files" },
        { "<leader>w", "<cmd>FzfLua live_grep_native<CR>", desc = "find words" },
        { "<esc>", "<c-c>", ft = "fzf", mode = "t", nowait = true },
    },
    cmd = "FzfLua",
    opts = {
        "default-title",
        winopts = { backdrop = false },
        oldfiles = ivy,
        files = merge {
            file_icons = "mini",
            fd_opts = {
                "-H",
                "-I",
                "--exclude={.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs} --type f --strip-cwd-prefix",
            },
        },
        grep = {
            grep_opts = {
                "--no-heading",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob", -- this flag allows you to hide exclude these files and folders from your search 👇
                "!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock,.vscode-server,.virtualenvs}",
            },
        },
    },
}
