return {
    "williamboman/mason.nvim",
    event = {
        "InsertEnter",
        "CmdlineEnter",
    },
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })


        require('mason-lspconfig').setup({
            -- A list of servers to automatically install if they're not already installed
            ensure_installed = { 'pylsp', 'clangd', 'lua_ls', 'rust_analyzer'},
        })
        -- 执行一个':masoninstall clang-format<cr>'的命令:
        -- vim.cmd[[:masonInstall clang-format<CR>]]
        
        

    end
}
