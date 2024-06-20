-- import all files in "user"
local files = vim.fn.globpath(vim.fn.stdpath "config" .. "/lua/user", "*.lua", true, true)

local function get_pluginname(str)
    local start_index, end_index = str:find "/user/(.-)%.lua$"
    local result = (start_index and end_index) and str:sub(start_index + 6, end_index - 4) or nil
    return (result and result ~= "init") and result or nil
end

-- auto-source all lua files in the user directory
for _, file in ipairs(files) do
    local plugin_name = get_pluginname(file)
    if plugin_name then
        require("user." .. plugin_name)
    end
end
