local keys = function()
  if vim.uv.os_uname().sysname ~= "Windows_NT" then
    return {
      { "<esc>", "<c-c>", ft = "fzf", mode = "t", nowait = true },
      { "<leader>f", "<cmd>FzfLua global<CR>", desc = "find files" },
      { "<leader>w", "<cmd>FzfLua live_grep<CR>", desc = "live grep" },
      { "<leader>r", "<cmd>FzfLua frecency cwd_only=false<CR>", desc = "recent files" },
      { "<leader>tt", "<cmd>FzfLua tabs<CR>", desc = "Fzflua Tabs" },
      { "<leader>th", "<cmd>FzfLua helptags<CR>", desc = "Fzflua Help" },
      { "<leader>tb", "<cmd>FzfLua buffers<CR>", desc = "Fzflua Buffer" },
      { "<leader>tk", "<cmd>FzfLua keymaps<CR>", desc = "Fzflua Keymaps" },
      { "<leader>tc", "<cmd>FzfLua commands<CR>", desc = "Fzflua Commands" },
      { "<leader>tl", "<cmd>FzfLua highlights<CR>", desc = "Fzflua Highlights" },
    }
  else
    return { { "<esc>", "<c-c>", ft = "fzf", mode = "t", nowait = true } }
  end
end

local opts = function(_, opts)
  local ivy = {
    previewers = { builtin = { toggle_behavior = "extend" } },
    fzf_opts = { ["--layout"] = "reverse", ["--marker"] = "+" },
    header = false,
    winopts = {
      height = 25,
      width = 1,
      row = 1,
      backdrop = false,
      preview = {
        scrollbar = false,
        hidden = "nohidden",
        layout = "flex",
        horizontal = "right:50%",
        flip_columns = 120,
      },
    },
    hls = {
      normal = "TelescopeNormal",
      border = "TelescopeBorder",
      title = "TelescopePromptTitle",
      help_normal = "TelescopeNormal",
      help_border = "TelescopeBorder",
      preview_normal = "TelescopeNormal",
      preview_border = "TelescopeBorder",
      preview_title = "TelescopePreviewTitle",
      cursor = "Cursor",
      cursorline = "TelescopeSelection",
      cursorlinenr = "TelescopeSelection",
      search = "IncSearch",
    },
  }

  local ivy_config = function(x) return vim.tbl_extend("force", ivy, x) end

  local filter = ".astro,.git,.npm,.idea,.direnv,.venv,.vscode,.cargo,.vscode-server,.husky,.orbstack,.cache,.rustup,.wakatime,.gnupg,"
    .. "bin,node_modules,build,target,.DS_Store,*.age"

  opts = {
    "default-title",
    winopts = {
      backdrop = false,
      preview = { delay = 50 },
    },
    frecency = ivy_config {
      fzf_opts = { ["--no-sort"] = false },
    },
    global = ivy_config {
      git_icons = false,
      pickers = {
        { "frecency", desc = "Files" },
        { "buffers", desc = "Bufs", prefix = "$" },
        { "lsp_document_symbols", desc = "Symbols (buf)", prefix = "@" },
        { "lsp_workspace_symbols", desc = "Symbols (project)", prefix = "#" },
      },
      fd_opts = "-H -I " .. "-E '{" .. filter .. "}' " .. "--type f --strip-cwd-prefix",
    },
    grep = {
      -- stylua: ignore
      rg_opts = "-. -n -S --no-heading --column "
          .. "--glob '!{" .. filter .. ",package-lock.json,pnpm-lock.yaml,yarn.lock}' ",
    },
    keymap = {
      fzf = {
        ["ctrl-u"] = "half-page-up",
        ["ctrl-d"] = "half-page-down",
      },
    },
  }
  return opts
end

---@type LazyPluginSpec[]
return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "echasnovski/mini.icons",
      "elanmed/fzf-lua-frecency.nvim",
    },
    cmd = "FzfLua",
    opts = opts,
    keys = keys,
  },
  {
    "elanmed/fzf-lua-frecency.nvim",
    event = "User AfterFile",
    opts = { cwd_only = true },
  },
}
