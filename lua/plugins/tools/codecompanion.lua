local opts = function(_, opts)
  local extend = require("codecompanion.adapters").extend
  opts = {
    opts = { language = "Chinese" },
    strategies = {
      inline = {
        adapter = "copilot",
        keymaps = {
          accept_change = { modes = { n = "." } },
          reject_change = { modes = { n = "," } },
          always_accept = { modes = { n = "ga" } },
        },
      },
      chat = {
        adapter = "copilot",
        roles = { user = "Parsifa1" },
        keymaps = {
          send = {
            index = 1,
            description = "Send",
            callback = function(chat)
              vim.cmd "stopinsert"
              chat:submit()
            end,
          },
          debug = { modes = { n = "gd" } },
        },
        tools = {
          opts = {
            default_tools = { "tools" },
          },
          groups = {
            ["tools"] = {
              description = "commonly used tools",
              prompt = "I'm giving you access to the ${tools} to help you perform coding tasks",
              tools = {
                -- native
                "read_file",
                "cmd_runner",
                "create_file",
                "file_search",
                "grep_search",
                "list_code_usages",
                "get_changed_files",
                "insert_edit_into_file",
                -- from McpHub
                -- "neovim__move_item",
                -- "neovim__execute_lua",
                -- "neovim__delete_items",
                -- "neovim__list_directory",
              },
            },
          },
        },
      },
    },
    display = {
      action_palette = { provider = "snacks" },
      diff = {
        provider_opts = {
          inline = {
            layout = "buffer",
          },
        },
      },
      chat = {
        window = {
          width = 0.35,
          opts = { number = false, numberwidth = 1, foldcolumn = "0" },
        },
        intro_message = "Welcome to CodeCompanion ✨!",
      },
    },
    ruls = {
      opts = {
        chat = {
          enabled = true,
          default_rules = "default",
        },
      },
    },
    adapters = {
      http = {
        copilot = function()
          return extend("copilot", {
            schema = { model = { default = "gemini-3-pro-preview" } },
          })
        end,
        gemini = function()
          return extend("gemini", {
            env = { api_key = "cmd:cat ~/.config/sops-nix/secrets/gemini-key" },
            schema = { model = { default = "gemini-2.5-pro" } },
          })
        end,
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          show_result_in_chat = true,
          make_slash_commands = true,
        },
      },
      history = {
        enabled = true,
        opts = {
          keymap = "gh",
          auto_save = true,
          picker = vim.uv.os_uname().sysname == "Windows_NT" and "snacks" or "fzf-lua",
          picker_keymaps = { delete = { n = "d", i = "<C-x>" } },
          save_chat_keymap = "gs",
          continue_last_chat = false,
          auto_generate_title = true,
          delete_on_clearing_chat = true,
        },
      },
      spinner = {},
    },
  }
  return opts
end

---@type LazyPluginSpec
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "ravitemer/mcphub.nvim",
    "ravitemer/codecompanion-history.nvim",
    { "parsifa1/llm-spinner", dev = true },
  },
  init = function() vim.cmd [[cab cc CodeCompanion]] end,
  cmd = { "CodeCompanionChat" },
  keys = {
    { "<leader>ah", "<cmd>CodeCompanionHistory<CR>", desc = "CodeCompanion Chat" },
    { "<leader>ac", "<cmd>CodeCompanionActions<CR>", desc = "CodeCompanion Chat" },
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", desc = "CodeCompanion Chat" },
  },
  opts = opts,
}
