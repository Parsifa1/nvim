---@diagnostic disable: unused-local
return {
    "goolord/alpha-nvim",
    config = function()
        local status_ok, alpha = pcall(require, "alpha")
        if not status_ok then
            return
        end

        local dashboard = require "alpha.themes.dashboard"
        dashboard.section.header.val = {
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡤⠤⢤⡤⠴⢤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡴⣞⣋⡁⣠⡤⢴⣋⡠⢄⣀⠀⠈⠛⠷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⡿⣟⠽⠛⢛⡜⣱⡞⠉⢮⡉⠑⢮⣑⢦⡀⠀⠈⠻⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⡏⢘⠁⢀⣴⡟⢁⡇⡇⠀⠈⢿⣦⠀⠙⣷⡙⢦⡀⠀⠸⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣏⠔⠁⣠⠊⣾⡇⢸⠁⣇⠀⠀⠘⣧⢃⠀⠘⣷⠈⢻⣆⠀⢹⡆⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⢟⡏⠀⡰⢣⢾⣿⠀⢸⠀⣿⠀⠀⠀⢿⡞⡆⠀⣿⣇⠈⢻⣆⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠇⡾⠀⢰⣷⠧⢺⢹⠀⢸⡀⠸⡇⠀⠀⠘⡇⢡⠀⢸⣽⡀⠈⣿⡀⣿⡀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣼⣻⠀⣿⠃⠀⠀⣿⡆⢸⣧⠀⢻⡉⠙⠒⢷⣸⠀⢸⣌⣧⡀⣾⣧⣯⣗⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⡇⢀⣯⣷⣶⣶⡿⣷⡘⣿⣆⡈⢿⣤⣆⠸⢸⠂⠀⣿⣼⣽⣿⡇⡏⢻⣇⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣧⠈⡿⡸⣿⣿⣿⠍⠛⠛⠉⢹⣿⣿⣿⢿⣿⣀⣠⣷⣿⢿⣵⣤⡇⢠⣿⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣷⣽⣔⠙⠒⠋⠀⠀⠀⠀⠀⠿⣉⣿⠃⡝⢡⣿⣿⡿⣸⣿⣄⣰⣿⠋⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠿⢛⡿⢹⣧⢸⢻⡏⠁⠀⠀⠀⠀⠀⠀⠀⢠⠀⣠⣾⣷⣿⢿⣿⣧⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⣠⣾⠁⣸⡇⡿⡿⣷⣄⠀⠀⠀⢠⡀⠀⠀⠀⠀⠀⣸⣇⡞⣿⣿⣿⡙⣿⢸⣿⢿⢿⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⢰⣿⡿⢻⢞⡽⣱⡾⣼⣿⣿⣿⣦⡀⠀⠀⠀⠀⣀⡤⠀⣟⡟⢠⣇⣻⡏⣇⣿⡀⣿⢾⣿⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⢀⣴⠟⡱⠀⢀⣾⢟⣿⣿⣿⣿⣿⡟⠛⠉⢩⠿⠛⠀⠀⢀⣼⡟⢡⣾⣿⠟⢿⣿⣆⢹⣿⢸⣿⠈⣿⡄⠀⠀⠀⠀]],
            [[⠀⡴⢻⣋⡞⡤⢶⣿⠏⣾⣿⣿⣿⣿⡿⠀⠀⢀⣿⣿⣷⣤⣠⣾⡿⣠⣿⡟⠁⣀⣠⣽⣿⡄⠈⠻⢿⡀⠙⣿⢦⡀⠀⠀]],
            [[⢰⣧⡿⣿⠀⢠⣾⡇⣸⣿⡟⢡⣯⡿⣇⠀⠀⣸⠇⠀⠹⣿⣿⣿⣠⣿⣿⣷⣾⣿⣿⢿⢿⣿⣆⢣⠀⢻⣤⡸⡌⢿⡄⠀]],
            [[⠸⣿⣧⢿⠷⣎⣿⠁⣿⡿⠃⠈⣿⢷⣿⡀⠀⡟⠀⣠⠞⣵⡿⢡⣿⣿⣿⣿⢛⣿⣷⣧⡞⠀⢹⣼⡇⢹⢿⡿⣿⠀⢿⡄]],
            [[⠀⠀⢹⡞⣤⣿⣿⣆⣿⣷⣴⣾⠁⠈⢿⣧⢠⣧⠞⠁⠀⣿⠇⢸⡿⠟⢡⡇⣸⡟⣿⣿⣿⠀⠀⢿⡇⠰⣿⡇⢹⠀⣸⡇]],
            [[⠀⠀⠘⠛⠙⣽⣿⣿⠟⢻⡾⠛⢯⡀⣼⣿⣾⣯⣶⣾⣿⠿⣶⣽⡦⠀⡜⢠⡟⠹⢿⣿⠈⣇⠀⢸⣧⣸⣿⠁⣸⣴⡿⠁]],
            [[⠀⠀⠀⠀⣴⠟⣿⢋⣤⣾⠃⠀⠀⣹⢟⣿⠉⣹⣿⣍⡁⠀⠀⣀⡥⠞⠁⠈⠀⢧⠀⠻⠂⠙⠀⠀⢹⡗⠃⠈⠉⠈⠁⠀]],
            [[⠀⠀⠀⠀⠀⣸⣿⣿⣫⠇⠀⣠⠞⣱⠛⣿⣿⢿⠹⡇⠀⣯⠉⠁⠀⠀⠀⠀⠀⢺⠀⠀⠀⠀⠀⠀⠈⣿⠀⠀⠀⠀⠀⠀]],
            [[]],
        }

        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", "<cmd>Telescope find_files <CR>"),
            dashboard.button("i", "󰇽  Project", "<cmd>Telescope workspaces theme=dropdown<CR><Esc>"),
            dashboard.button("r", "  Recently used files", "<cmd>Telescope oldfiles <CR>"),
            dashboard.button("p", "󰂖  Plugins", "<cmd>Lazy<CR>"),
            dashboard.button("q", "󰅚  Quit Neovim", "<cmd>qa<CR>"),
        }

        local function footer()
            return "Hinc itur ad astra"
        end

        dashboard.section.footer.val = footer()
        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.footer.opts.position = "center"
        dashboard.section.header.opts.position = "center"
        dashboard.section.header.opts.hl = "Include"
        dashboard.section.buttons.opts.hl = "Keyword"
        dashboard.opts.opts.noautocmd = true

        require("alpha").setup(dashboard.config)

        vim.api.nvim_create_autocmd("User", {
            callback = function()
                local stats = require("lazy").stats()
                local ms = math.floor(stats.startuptime * 100) / 100
                dashboard.section.footer.val = "󱐌 Lazy-loaded "
                    .. stats.loaded
                    .. "/"
                    .. stats.count
                    .. " plugins in "
                    .. ms
                    .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
