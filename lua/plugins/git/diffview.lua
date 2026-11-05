---@diagnostic disable: duplicate-set-field
return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    { "<leader>gdo", "<Cmd>CodeDiff<CR>", desc = "Open Diff" },
    { "<leader>gdh", "<Cmd>CodeDiff history<CR>", desc = "Open History" },
    { "<leader>gdf", "<Cmd>CodeDiff history %<CR>", desc = "Current History" },
  },
  opts = function()
    local explorer_width = math.floor(vim.go.columns * 0.2) > 25
        and math.floor(vim.go.columns * 0.2)
      or 25
    return {
      diff = { layout = "inline", filler_text = "╱" },
      highlights = {
        line_insert = "#344139",
        line_delete = "#403135",
        char_insert = "#445847",
        char_delete = "#5b3d43",
      },
      explorer = { position = "left", width = explorer_width, view_mode = "tree" },
      keymaps = {
        view = { quit = { "q", "<Esc>" } },
        conflict = {
          accept_current = "co",
          accept_incoming = "ct",
          accept_both = "ca",
          discard = "c0",
          next_conflict = "]c",
          prev_conflict = "[c",
        },
      },
    }
  end,
  config = function(_, opts)
    local diff = require "codediff.core.diff"
    local raw_compute = diff.compute_diff
    diff.compute_diff = function(...)
      local res = raw_compute(...)
      for _, c in ipairs(res and res.changes or {}) do
        local o, m = c.original, c.modified
        if o.end_line <= o.start_line or m.end_line <= m.start_line then c.inner_changes = nil end
      end
      return res
    end

    local inline = require "codediff.ui.inline"
    local raw_inline = inline.render_inline_diff
    inline.render_inline_diff = function(buf, res, a, b, o)
      local lifecycle = require "codediff.ui.lifecycle"
      local s = lifecycle.get_session(vim.api.nvim_get_current_tabpage())
      local path = s and tostring(s.modified or s.original)
      local ft = path and vim.filetype.match { filename = path } or vim.bo[buf].filetype
      local extra = { filetype = ft ~= "" and ft or "lua" }
      return raw_inline(buf, res, a, b, vim.tbl_extend("force", o or {}, extra))
    end

    require("codediff").setup(opts)
  end,
}
