---@class Utils.function
local M = {}

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
