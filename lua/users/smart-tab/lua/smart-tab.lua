local M = {}

-- Position history stack
local position_history = {}

---@class SmartTabConfig
---@field skips (string|fun(node_type: string):boolean)[]
---@field mapping string|boolean
---@field backward_mapping string|boolean
---@field exclude_filetype string[]
local configs = {
    skips = { "string_content" },
    mapping = "<tab>",
    backward_mapping = "<S-tab>",
    exclude_filetype = {},
}

local function is_blank_line()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    local left_of_cursor = current_line:sub(1, col)
    return left_of_cursor:match "^%s*$" ~= nil
end

local function not_empty_history()
    if #position_history == 0 then
        vim.notify("No previous position to jump to", vim.log.levels.INFO)
        return false
    else
        return true
    end
end

---@param node_type string
local function should_skip(node_type)
    for _, skip in ipairs(configs.skips) do
        if type(skip) == "string" and skip == node_type then
            return true
        elseif type(skip) == "function" and skip(node_type) then
            return true
        end
    end
    return false
end

---smart tab
---
---returns false if TS not available/parent doesn't exist
---@return boolean
function M.smart_tab()
    local node_ok, node = pcall(vim.treesitter.get_node)
    if not node_ok then
        vim.notify "Treesitter not available"
        return false
    end
    while node and should_skip(node:type()) do
        node = node:parent()
    end
    if not node then
        vim.notify "No valid parent node"
        return false
    end
    local luasnip_ok, luasnip = pcall(require, "luasnip")
    if luasnip_ok and luasnip.expand_or_locally_jumpable() then
        luasnip.expand {}
        return false
    end

    local current_pos = vim.api.nvim_win_get_cursor(0)
    local row, col = node:end_()
    local ok = pcall(vim.api.nvim_win_set_cursor, 0, { row + 1, col })

    -- Only save position if we actually moved
    if ok then
        table.insert(position_history, current_pos)
    else
        ok = pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
    end

    return ok
end

---Jump back to the previous cursor position
---@return boolean
function M.smart_tab_backward()
    local prev_pos = table.remove(position_history)
    local ok = pcall(vim.api.nvim_win_set_cursor, 0, prev_pos)
    return ok
end

---Clear the position history stack
function M.clear_position_history()
    position_history = {}
end

local function setup_keymap(filetype, buffer)
    if vim.tbl_contains(configs.exclude_filetype, filetype) then
        return
    end

    local mapping = configs.mapping--[[@as string]]
    local backward_mapping = configs.backward_mapping--[[@as string]]

    -- Setup forward tab mapping
    vim.keymap.set("i", mapping, function()
        if is_blank_line() or not M.smart_tab() then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(mapping, true, true, true), "n", false)
        end
    end, {
        buffer = buffer,
        desc = "smart-tab",
    })

    -- Setup backward tab mapping
    if backward_mapping then
        vim.keymap.set("i", backward_mapping, function()
            if not_empty_history() and not M.smart_tab_backward() then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(backward_mapping, true, true, true), "n", false)
            end
        end, {
            buffer = buffer,
            desc = "smart-tab-backward",
        })
    end
end

---setup smart-tab plugin
---@param opts? SmartTabConfig
function M.setup(opts)
    opts = opts or {}
    configs = vim.tbl_extend("force", configs, opts)
    if configs.mapping then
        -- Setup FileType autocmd for keymap
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(event)
                setup_keymap(event.match, event.buf)
            end,
        })

        -- Clear position history when leaving insert mode
        vim.api.nvim_create_autocmd("ModeChanged", {
            pattern = "*:n",
            callback = function()
                M.clear_position_history()
            end,
        })

        -- load `setup_keymap` manually to work with lazy-loading
        local buffer = vim.api.nvim_get_current_buf()
        setup_keymap(vim.bo.filetype, buffer)
    end
end

return M
