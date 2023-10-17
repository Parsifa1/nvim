return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim'
    },
    event = {
        "InsertEnter",
        "CmdlineEnter",
    },
    config = function()
        -- Set different settings for different languages' LSP
        -- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        -- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
        --     - the settings table is sent to the LSP
        --     - on_attach: a lua callback function to run after LSP atteches to a given buffer
        local lspconfig = require('lspconfig')
        -- Customized on_attach function
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        local opts = { noremap = true, silent = true }
        -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local function bufopts_desc(index)
                return {
                    noremap = true,
                    silent = true,
                    buffer = bufnr,
                    desc = index
                }
            end
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts_desc('declaration'))
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts_desc('definition'))
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts_desc('hover'))
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts_desc('implementation'))
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts_desc('signature help'))
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts_desc('type definition'))
            vim.keymap.set('n', '<leader>cn', vim.lsp.buf.rename, bufopts_desc('rename'))
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts_desc('code action'))
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts_desc('references'))
            -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            -- vim.keymap.set('n', '<leader>wl', function()
            --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            -- end, bufopts)
            --vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
        end
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "General LSP Attach",
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint(bufnr, true)
                end
            end
        })

        lspconfig.pylsp.setup({
            on_attach = on_attach,
        })
        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            settings = {
                Lua = { diagnostics = { globals = { "vim" } } },
            }
        })

        lspconfig.clangd.setup({
            on_attach = on_attach,
            filetypes = { "cpp" },
            cmd = { "C:/Program Files/mingw64/bin/clangd.exe" },
        })
    end
}
