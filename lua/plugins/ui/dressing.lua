---@diagnostic disable: duplicate-set-field

local init = function()
    vim.ui.select = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.select(...)
    end
    vim.ui.input = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.input(...)
    end
end

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
    init = init,
    opts = {
        select = {
            backend = { "fzf_lua", "telescope" },
            get_config = function(opts)
                if opts.prompt == "Load Session" then
                    local backend = "fzf_lua"
                    local themes = require "telescope.themes"
                    if vim.uv.os_uname().sysname == "Windows_NT" then
                        backend = "telescope"
                    end
                    return {
                        backend = { backend },
                        telescope = themes.get_dropdown {
                            initial_mode = "normal",
                        },
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
