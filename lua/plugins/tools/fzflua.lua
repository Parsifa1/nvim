-- local utils = require("fzf-lua").utils
-- local actions = require("fzf-lua").actions
--
-- local function hl_validate(hl)
--     return not utils.is_hl_cleared(hl) and hl or nil
-- end

return {
    "ibhagwan/fzf-lua",
    enabled = true,
        keys = { { "<leader>f", "<cmd>FzfLua files<CR>", desc = "open files" } },
    cmd = "FzfLua",
    opts = {
        { "default-title" }, -- base profile
        files = {
            previewers = { builtin = { toggle_behavior = "extend" } },
            fzf_opts = { ["--layout"] = "reverse", ["--marker"] = "+" },
            header = false,
            winopts = {
                height = 25,
                width = 1,
                row = 1,
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
        },
    },
}
