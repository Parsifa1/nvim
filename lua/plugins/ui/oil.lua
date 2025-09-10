---@diagnostic disable: param-type-mismatch
local custom = require "config.custom"
return {
  "stevearc/oil.nvim",
  init = function()
    if vim.fn.argc() == 1 then
      -- local stat = vim.loop.fs_stat(vim.fn.argv(0))
      -- if stat then
      require("lazy").load { plugins = { "oil.nvim" } }
      -- end
    end
    if not require("lazy.core.config").plugins["oil.nvim"]._.loaded then
      vim.api.nvim_create_autocmd("BufNew", {
        callback = function()
          if vim.fn.isdirectory(vim.fn.expand "<afile>") == 1 then
            require("lazy").load { plugins = { "oil.nvim" } }
            return true
          end
        end,
      })
    end
  end,
  keys = {
    {
      "-",
      function()
        if vim.bo.filetype ~= "minifiles" then require("oil").open() end
      end,
      desc = "Open parent directory",
    },
  },
  opts = {
    columns = { "icon" },
    cleanup_delay_ms = false,
    silence_scp_warning = true,
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _) return name == ".DS_Store" end,
    },
    skip_confirm_for_simple_edits = true,
    float = {
      border = custom.border,
    },
    preview = {
      border = custom.border,
    },
    progress = {
      border = custom.border,
    },
    adapter_aliases = {
      ["scp://"] = "oil-ssh://",
    },
    keymaps = {
      ["<C-s>"] = false,
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<CR>"] = "actions.select",
      ["zs"] = "actions.select_split",
      ["zv"] = "actions.select_vsplit",
      ["L"] = "actions.select",
      ["H"] = "actions.parent",
      ["-"] = "actions.close",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["."] = "actions.toggle_hidden",
    },
  },
}
