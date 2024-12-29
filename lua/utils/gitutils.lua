local M = {}
local git_cache = {} ---@type table<string, boolean>
local function is_git_root(dir)
    if git_cache[dir] == nil then
        git_cache[dir] = (vim.uv or vim.loop).fs_stat(dir .. "/.git") ~= nil
    end
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
        if git_cache[dir] then
            return vim.fs.normalize(dir) or nil
        end
    end
    for dir in vim.fs.parents(path) do
        if is_git_root(dir) then
            return vim.fs.normalize(dir) or nil
        end
    end
end

return M
