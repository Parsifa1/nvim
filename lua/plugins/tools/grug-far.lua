return {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
        { "<leader>sf", "<cmd>GrugFar astgrep<CR>", desc = "Find and Replace in files" },
    },
    config = function()
        require("grug-far").setup { transient = true }
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("grug-far-keybindings", { clear = true }),
            pattern = { "grug-far" },
            callback = function()
                vim.keymap.set("n", "<Esc>", function()
                    require("grug-far").get_instance(0):close()
                end, { buffer = true })
            end,
        })
    end,
}
