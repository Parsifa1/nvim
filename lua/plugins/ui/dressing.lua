local session_config = {
    prompt = false,
    winopts = {
        height = 0.35,
        width = 0.45,
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
            backend = { "fzf_lua", "snacks_picker" },
            get_config = function(opts)
                if opts.prompt == "Load Session" then
                    local backend = vim.uv.os_uname().sysname == "Windows_NT" and "snacks_picker" or "fzf_lua"
                    return {
                        backend = { backend },
                        fzf_lua = session_config,
                    }
                end
                if opts.kind == "codeaction" then
                    return {}
                end
            end,
            fzf_lua = {
                winopts = {
                    height = 0.25,
                    width = 0.37,
                    row = 0.50,
                    col = 0.50,
                },
            },
        },
    },
}
