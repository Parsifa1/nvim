local custom = require "config.custom"

return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 16
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    on_create = function(t)
      local bufnr = t.bufnr
      vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { buffer = bufnr })
    end,
    ---@diagnostic disable-next-line: undefined-field
    shell = vim.uv.os_uname().sysname == "Windows_NT" and "pwsh -nologo" or "fish",
    shade_terminals = false,
    float_opts = {
      border = custom.border,
    },
  },
  keys = function()
    local float_opts = {
      border = custom.border,
    }

    return {
      { "<C-\\>" },
      { "`", "<cmd>ToggleTerm<CR>", mode = { "n", "t" }, desc = "Terminal" },
      { "<C-`>", "<cmd>ToggleTerm direction=vertical<CR>", mode = { "n", "t" }, desc = "Terminal" },
      {
        "`",
        function()
          vim.cmd "ToggleTerm"
          if vim.fn.mode() == "n" then vim.cmd "startinsert" end
        end,
        mode = "t",
        desc = "Terminal",
      },
      -- External programs
      {
        "<leader>gl",
        function()
          require("toggleterm.terminal").Terminal
            :new({
              cmd = "lazygit",
              hidden = true,
              direction = "float",
              float_opts = float_opts,
              on_create = function(t)
                local bufnr = t.bufnr
                vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = bufnr })
              end,
            })
            :toggle()
        end,
        desc = "LazyGit",
      },
      {
        "<leader>gf",
        function()
          require("toggleterm.terminal").Terminal
            :new({
              cmd = "yazi",
              hidden = true,
              direction = "float",
              float_opts = float_opts,
              on_create = function(t)
                local bufnr = t.bufnr
                vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = bufnr })
              end,
            })
            :toggle()
        end,
        desc = "Yazi",
      },
    }
  end,
}
