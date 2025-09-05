return {
    "vuki656/package-info.nvim",
    commit = "268f466",
    event = { "BufRead package.json" },
    config = function()
        require("package-info").setup {
            autostart = false,
            package_manager = "pnpm",
        }
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "package.json",
            callback = function()
                -- wait for 0.05s
                vim.defer_fn(function()
                    pcall(function() require("package-info").show() end)
                end, 500)
            end,
        })
    end,
}
