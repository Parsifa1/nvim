local opts = {
    opts = { language = "Chinese" },
    strategies = {
        inline = { adapter = "copilot" },
        chat = {
            adapter = "copilot",
            roles = { user = "Parsifa1" },
            keymaps = {
                send = {
                    callback = function(chat)
                        vim.cmd "stopinsert"
                        chat:submit()
                    end,
                    index = 1,
                    description = "Send",
                },
            },
        },
    },
    display = {
        chat = {
            window = {
                width = 0.35,
                opts = { number = false, numberwidth = 1 },
            },
            intro_message = "Welcome to CodeCompanion ✨!",
        },
    },
    adapters = {
        copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
                schema = { model = { default = "gemini-2.5-pro" } },
            })
        end,
    },
    extensions = {
        mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
                make_vars = true, -- Convert resources to #variables
                show_result_in_chat = true, -- Show mcp tool results in chat
                make_slash_commands = true, -- Add prompts as /slash commands
            },
        },
        history = {
            enabled = true,
            opts = {
                keymap = "gh",
                auto_save = true,
                picker = "snacks",
                save_chat_keymap = "gs",
                continue_last_chat = false,
                auto_generate_title = true,
                delete_on_clearing_chat = true,
            },
        },
    },
}

---@type LazyPluginSpec
return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "ravitemer/codecompanion-history.nvim",
        { "parsifa1/llm-spinner", dev = true },
    },
    cmd = { "CodeCompanionChat" },
    keys = {
        { "<leader>ah", "<cmd>CodeCompanionHistory<CR>", desc = "CodeCompanion Chat" },
        { "<leader>ac", "<cmd>CodeCompanionActions<CR>", desc = "CodeCompanion Chat" },
        { "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", desc = "CodeCompanion Chat" },
    },
    opts = function()
        vim.cmd [[cab cc CodeCompanion]]
        require("llm-spinner"):init()
        return opts
    end,
}
