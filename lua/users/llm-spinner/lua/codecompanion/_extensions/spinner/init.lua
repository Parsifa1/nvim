---@class CodeCompanion.Extension
---@field setup fun(opts: table) Function called when extension is loaded
local M = {}

function M.setup(_)
    require("llm-spinner"):init()
end

return M
