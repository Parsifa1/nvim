---@class Utils.function
local M = {}

--- Trigger an AstroNvim user event
---@param event string| string[]
---@param instant? boolean Whether or not to execute instantly or schedule
function M.mkEvent(event, instant)
  if type(event) == "string" then event = { pattern = event } end
  event = require("config.custom").extend_tbl({ modeline = false }, event)
  event.pattern = event.pattern
  if instant then
    vim.api.nvim_exec_autocmds("User", event)
  else
    vim.schedule(function() vim.api.nvim_exec_autocmds("User", event) end)
  end
end

--- Run a shell command and capture the output and if the command succeeded or failed
---@param cmd string|string[] The terminal command to execute
---@param show_error? boolean Whether or not to show an unsuccessful command as an error to the user
---@return string|nil result The result of a successfully executed command or nil
function M.cmd(cmd, show_error)
  if type(cmd) == "string" then cmd = { cmd } end
  if vim.fn.has "win32" == 1 then cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd) end
  local result = vim.fn.system(cmd)
  local success = vim.api.nvim_get_vvar "shell_error" == 0
  if not success and (show_error == nil or show_error) then
    ---@diagnostic disable-next-line: deprecated
    vim.api.nvim_err_writeln(("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result))
  end
  return success and assert(result):gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
end

--- Get the first worktree that a file belongs to
---@param file? string the file to check, defaults to the current file
---@param worktrees table<string, string>[]? an array like table of worktrees with entries `toplevel` and `gitdir`, default retrieves from `vim.g.git_worktrees`
---@return table<string, string>|nil worktree a table specifying the `toplevel` and `gitdir` of a worktree or nil if not found
function M.file_worktree(file, worktrees)
  if not worktrees then return end
  file = file or vim.fn.expand "%" --[[@as string]]
  for _, worktree in ipairs(worktrees) do
    if
      M.cmd({
        "git",
        "--work-tree",
        worktree.toplevel,
        "--git-dir",
        worktree.gitdir,
        "ls-files",
        "--error-unmatch",
        file,
      }, false)
    then
      return worktree
    end
  end
end

--- Check if a buffer is valid
---@param bufnr? integer The buffer to check, default to current buffer
---@return boolean # Whether the buffer is valid or not
function M.is_valid(bufnr)
  if not bufnr then bufnr = 0 end
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

-- autocmds
function M.loadAutocmd(opts)
  for augroup, autocmds in pairs(opts) do
    if autocmds then
      local augroup_id = vim.api.nvim_create_augroup(augroup, { clear = true })
      local function load_autocmd(autocmd)
        local event = autocmd.event
        autocmd.event = nil
        autocmd.group = augroup_id
        vim.api.nvim_create_autocmd(event, autocmd)
        autocmd.event = event
      end
      if #autocmds == 0 then load_autocmd(autocmds) end
      for _, autocmd in ipairs(autocmds) do
        load_autocmd(autocmd)
      end
    end
  end
end

-- Width of side windows
function M.width()
  local columns = vim.go.columns
  return math.floor(columns * 0.15) > 28 and math.floor(columns * 0.15) or 28
end

function M.set(mode, keys, func, ...)
  local options = { noremap = true, silent = true }
  local arg = { ... }
  if #arg > 0 then
    local desc = arg[1]
    options.desc = desc
  end

  vim.keymap.set(mode, keys, func, options)
end

--- Git Utils
local git_cache = {} ---@type table<string, boolean>
local function is_git_root(dir)
  if git_cache[dir] == nil then git_cache[dir] = (vim.uv or vim.loop).fs_stat(dir .. "/.git") ~= nil end
  return git_cache[dir]
end
--- Gets the git root for a buffer or path.
--- Defaults to the current buffer.
---@param path? number|string buffer or path
function M.get_root(path)
  path = path or 0
  path = type(path) == "number" and vim.api.nvim_buf_get_name(path) or path --[[@as string]]
  path = vim.fs.normalize(path)
  path = path == "" and (vim.uv or vim.loop).cwd() .. "/foo" or path
  -- check cache first
  for dir in vim.fs.parents(path) do
    if git_cache[dir] then return vim.fs.normalize(dir) or nil end
  end
  for dir in vim.fs.parents(path) do
    if is_git_root(dir) then return vim.fs.normalize(dir) or nil end
  end
end

function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

return M
