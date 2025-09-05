---@diagnostic disable: undefined-global
local custom = require "config.custom"

local custom_path = {
    get_symbols = function(buff, win, cursor)
        local symbols = require("dropbar.sources").path.get_symbols(buff, win, cursor)
        vim.api.nvim_set_hl(0, "DropBarFileName", { fg = "#FCDCDD", italic = true })
        symbols[#symbols].name_hl = "DropBarFileName"
        if vim.bo[buff].modified then
            symbols[#symbols].name = symbols[#symbols].name .. " [+]"
            symbols[#symbols].name_hl = "DiffAdded"
        end
        return symbols
    end,
}

---@type LazyPluginSpec
return {
    "Bekaboo/dropbar.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {
        icons = { kinds = { symbols = custom.icons.kind_with_space } },
        bar = {
            enable = function(buf, win, _)
                if
                    not vim.api.nvim_buf_is_valid(buf)
                    or not vim.api.nvim_win_is_valid(win)
                    or vim.fn.win_gettype(win) ~= ""
                    or vim.wo[win].winbar ~= ""
                    or vim.bo[buf].ft == "codecompanion"
                    or vim.bo[buf].ft == "help"
                then
                    return false
                end

                return vim.bo[buf].ft == "markdown"
                    or pcall(vim.treesitter.get_parser, buf)
                    or not vim.tbl_isempty(vim.lsp.get_clients {
                        bufnr = buf,
                        method = "textDocument/documentSymbol",
                    })
            end,
            sources = function(buf, _)
                local sources = require "dropbar.sources"
                local utils = require "dropbar.utils"
                if vim.bo[buf].ft == "markdown" then return { custom_path, sources.markdown } end
                if vim.bo[buf].buftype == "terminal" then return { sources.terminal } end
                return {
                    custom_path,
                    utils.source.fallback {
                        sources.lsp,
                        sources.treesitter,
                    },
                }
            end,
        },
    },
}
