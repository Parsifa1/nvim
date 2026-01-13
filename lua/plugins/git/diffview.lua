---@type LazyPluginSpec
return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
  },
  keys = {
    { "<leader>gdo", "<Cmd>DiffviewOpen<CR>", desc = "Open" },
    { "<leader>gdc", "<Cmd>DiffviewClose<CR>", desc = "Close" },
    { "<leader>gdh", "<Cmd>DiffviewFileHistory<CR>", desc = "Open History" },
    {
      "<leader>gdf",
      "<Cmd>DiffviewFileHistory %<CR>",
      desc = "Current History",
    },
  },
  ---@param opts DiffviewConfig
  opts = function(_, opts)
    local actions = require "diffview.actions"
    opts = {
      enhanced_diff_hl = true,
      show_help_hints = false,
      file_panel = {
        win_config = {
          width = math.floor(vim.go.columns * 0.2) > 25 and math.floor(vim.go.columns * 0.2) or 25,
        },
      },
      view = {
        merge_tool = { layout = "diff3_mixed" },
      },
      hooks = {
        diff_buf_win_enter = function(_, winid)
          vim.wo[winid].foldlevel = 99
          vim.wo[winid].wrap = false
        end,
      },
      keymaps = {
        disable_defaults = true,
        view = {
          { "n", "q", actions.close, { desc = "Close diffview" } },
          { "n", "<Esc>", actions.close, { desc = "Close diffview" } },
          { "n", "[c", actions.prev_conflict, { desc = "Prev Conflict" } },
          { "n", "]c", actions.next_conflict, { desc = "Next Conflict" } },
          { "n", "ca", actions.conflict_choose "all", { desc = "Choose ALL" } },
          { "n", "co", actions.conflict_choose "ours", { desc = "Choose OURS" } },
          { "n", "cb", actions.conflict_choose "base", { desc = "Choose BASE" } },
          { "n", "ct", actions.conflict_choose "theirs", { desc = "Choose THEIRS" } },
          { "n", "c0", actions.conflict_choose "none", { desc = "Choose NONE" } },
        },
        file_panel = {
          { "n", "q", actions.close, { desc = "Close diffview" } },
          { "n", "<Esc>", actions.close, { desc = "Close diffview" } },
          { "n", "<cr>", actions.select_entry, { desc = "Open the diff" } },
        },
        file_history_panel = {
          { "n", "q", actions.close, { desc = "Close diffview" } },
          { "n", "<Esc>", actions.close, { desc = "Close diffview" } },
        },
      },
    }
    return opts
  end,
}
