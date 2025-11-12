local utils = require "config.custom"

local mkNamespace = vim.api.nvim_create_namespace
local mid_mapping = false

local opts = {
  no_comment = {
    event = "FileType",
    pattern = "*",
    desc = "set no comment in next line",
    command = "set formatoptions-=ro",
  },
  auto_wrap = {
    event = "FileType",
    desc = "set wrap only for markdown, typst and codecompanion",
    pattern = { "markdown", "typst", "codecompanion" },
    command = "setlocal wrap",
  },
  highlight_yank = {
    event = "TextYankPost",
    desc = "Highlight when yanking (copying) text",
    callback = function() vim.hl.on_yank() end,
  },
  q_close_windows = {
    event = "BufWinEnter",
    desc = "Make q close help, man, quickfix, dap floats",
    callback = function(args)
      -- Add cache for buffers that have already had mappings created
      if not vim.g.q_close_windows then vim.g.q_close_windows = {} end
      -- If the buffer has been checked already, skip
      if vim.g.q_close_windows[args.buf] then return end
      -- Mark the buffer as checked
      vim.g.q_close_windows[args.buf] = true
      -- Check to see if `q` is already mapped to the buffer (avoids overwriting)
      for _, map in ipairs(vim.api.nvim_buf_get_keymap(args.buf, "n")) do
        if map.lhs == "q" then return end
      end
      -- If there is no q mapping already and the buftype is a non-real file, create one
      if vim.tbl_contains({ "help", "nofile", "quickfix" }, vim.bo[args.buf].buftype) then
        vim.keymap.set("n", "q", "<Cmd>close<CR>", {
          desc = "Close window",
          buffer = args.buf,
          silent = true,
          nowait = true,
        })
      end
    end,
  },
  checktime = {
    event = { "FocusGained", "TermClose", "TermLeave" },
    desc = "Check if we need to reload the file when it changed",
    callback = function()
      if vim.o.buftype ~= "nofile" then vim.cmd "checktime" end
    end,
  },
  diag_in_select = {
    {
      event = "ModeChanged",
      pattern = "*:s",
      desc = "Disable diagnostics in select mode",
      callback = function() vim.diagnostic.enable(false) end,
    },
    {
      event = "ModeChanged",
      pattern = "[is]:n",
      desc = "Enable diagnostics when leaving select mode",
      callback = function() vim.diagnostic.enable() end,
    },
  },
  fix_terminal_padding = {
    {
      event = { "UIEnter", "ColorScheme" },
      desc = "Fix terminal padding",
      callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then return end
        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
      end,
    },
    {
      event = "UILeave",
      desc = "Reset terminal padding",
      callback = function() io.write "\027]111\027\\" end,
    },
  },
  auto_trigger_fold = {
    {
      event = { "BufWinLeave", "BufWritePost", "WinLeave" },
      desc = "Save view with mkview for real files",
      callback = function(args)
        if vim.b[args.buf].view_activated then vim.cmd.mkview { mods = { emsg_silent = true } } end
      end,
    },
    {
      event = "BufWinEnter",
      desc = "Try to load file view if available and enable view saving for real files",
      callback = function(args)
        if not vim.b[args.buf].view_activated then
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
          local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
          local ignore_filetypes = { "gitcommit", "gitrebase" }
          if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
            vim.b[args.buf].view_activated = true
            vim.cmd.loadview { mods = { emsg_silent = true } }
          end
        end
      end,
    },
  },
  auto_remove_snippet = {
    event = "CursorMovedI",
    pattern = "*",
    desc = "Forget the current snippet when leaving the insert mode",
    callback = function(ev)
      local ls = require "luasnip"
      if not ls.session or not ls.session.current_nodes[ev.buf] or ls.session.jump_active then return end
      local current_node = ls.session.current_nodes[ev.buf]
      local current_start, current_end = current_node:get_buf_position()
      current_start[1] = current_start[1] + 1 -- (1, 0) indexed
      current_end[1] = current_end[1] + 1 -- (1, 0) indexed
      local cursor = vim.api.nvim_win_get_cursor(0)
      if
        cursor[1] < current_start[1]
        or cursor[1] > current_end[1]
        or cursor[2] < current_start[2]
        or cursor[2] > current_end[2]
      then
        ls.unlink_current()
      end
    end,
  },
  lazyload_forfile = {
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    desc = "custom lazyload",
    callback = function()
      local function _trigger() vim.api.nvim_exec_autocmds("User", { pattern = "AfterFile" }) end
      if vim.bo.filetype == "snacks_dashboard" then
        vim.api.nvim_create_autocmd("BufReadPost", { once = true, callback = _trigger })
      else
        _trigger()
      end
    end,
  },
  create_dir = {
    event = "BufWritePre",
    desc = "Automatically create parent directories if they don't exist when saving a file",
    callback = function(args)
      local file = args.match
      if not utils.is_valid(args.buf) or file:match "^%w+:[\\/][\\/]" then return end
      vim.fn.mkdir(vim.fn.fnamemodify(vim.uv.fs_realpath(file) or file, ":p:h"), "p")
    end,
  },
}

-- fix hlsearch when using n, N, *, #, ?, / in normal mode
vim.on_key(function(char)
  if vim.fn.mode() == "n" and not mid_mapping then
    local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    if vim.o.hlsearch ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
    mid_mapping = true
    vim.schedule(function() mid_mapping = false end)
  end
end, mkNamespace "luasnip_delete_on_sneak")

-- autocmds
utils.loadAutocmd(opts)
