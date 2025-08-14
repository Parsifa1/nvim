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

local keys = function()
    if vim.uv.os_uname().sysname ~= "Windows_NT" then
        return {
            { "<esc>", "<c-c>", ft = "fzf", mode = "t", nowait = true },
            { "<leader>f", "<cmd>FzfLua global<CR>", desc = "find files" },
            { "<leader>w", "<cmd>FzfLua live_grep<CR>", desc = "live grep" },
            { "<leader>r", "<cmd>FzfLua frecency<CR>", desc = "recent files" },
            { "<leader>tc", "<cmd>FzfLua commands<CR>", desc = "Fzflua Commands" },
            { "<leader>tk", "<cmd>FzfLua keymaps<CR>", desc = "Fzflua Keymaps" },
            { "<leader>tl", "<cmd>FzfLua highlights<CR>", desc = "Fzflua Highlights" },
            { "<leader>th", "<cmd>FzfLua helptags<CR>", desc = "Fzflua Help" },
        }
    else
        return { { "<esc>", "<c-c>", ft = "fzf", mode = "t", nowait = true } }
    end
end

local merge = function(x)
    return vim.tbl_extend("force", ivy, x)
end

local filter =
    ".astro,.git,.npm,.idea,.direnv,.vscode,.cargo,node_modules,build,.vscode-server,target,.orbstack,.cache,.rustup,.wakatime,.DS_Store,*.age"

return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "echasnovski/mini.icons", "elanmed/fzf-lua-frecency.nvim" },
        enabled = true,
        keys = keys(),
        cmd = "FzfLua",
        opts = {
            "default-title",
            winopts = {
                backdrop = false,
                preview = { delay = 50 },
            },
            frecency = ivy,
            global = merge {
                git_icons = false,
                fd_opts = "-H -I " .. "-E '{" .. filter .. "}' " .. "--type f --strip-cwd-prefix",
            },
            grep = {
                -- stylua: ignore
                rg_opts = "-. -n -S --no-heading --column "
                    .. "--glob '!{" .. filter .. ",package-lock.json,pnpm-lock.yaml,yarn.lock}' ",
            },
            keymap = {
                fzf = {
                    ["ctrl-u"] = "half-page-up",
                    ["ctrl-d"] = "half-page-down",
                },
            },
        },
    },
    {
        "elanmed/fzf-lua-frecency.nvim",
        opts = {
            cwd_only = true,
            display_score = false,
        },
    },
}
