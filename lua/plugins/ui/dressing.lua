local session_config = {
    prompt = false,
    winopts = {
        height = 0.35,
        width = 0.47,
        row = 0.50,
        col = 0.50,
        title_pos = "center",
        title = " Sessions ",
    },
    hls = { title = "TelescopePromptTitle" },
}

return {
    "stevearc/dressing.nvim",
    opts = {
        select = {
            backend = { "fzf_lua", "telescope" },
            get_config = function(opts)
                if opts.prompt == "Load Session" then
                    local themes = require "telescope.themes"
                    local backend = vim.uv.os_uname().sysname == "Windows_NT" and "telescope" or "fzf_lua"
                    return {
                        backend = { backend },
                        telescope = themes.get_dropdown {},
                        fzf_lua = session_config,
                    }
                end
                if opts.kind == "codeaction" then
                    return {}
                end
            end,
            fzf_lua = {
                winopts = {},
            },
        },
    },
}
