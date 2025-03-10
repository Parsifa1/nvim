return {
    "lervag/vimtex",
    enabled = false,
    ft = { "tex" },
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = "zathura"
        -- vim.api.nvim_create_autocmd("FileType", {
        --     pattern = "markdown",
        --     command = [[call vimtex#init()]],
        -- })
    end,
}
