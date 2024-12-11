return {
    "vuki656/package-info.nvim",
    event = { "BufRead package.json" },
    ft = "json",
    config = function()
        require("package-info").setup {
            autostart = false,
            package_manager = "pnpm",
        }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "json",
            callback = function()
                -- 等待0.5秒
                if vim.fn.expand "%:t" == "package.json" then
                    vim.defer_fn(function()
                        require("package-info").show()
                    end, 500)
                end
            end,
        })
    end,
}
