local config = function()
  local cm = require "cokeline.mappings"
  local get_hex = require("cokeline.hlgroups").get_hl_attr
  local errors_fg = get_hex("DiagnosticError", "fg")
  local warnings_fg = get_hex("DiagnosticWarn", "fg")
  ---@type Component[]
  local components = {
    icon = {
      text = function(buffer)
        return (cm.is_picking_focus() or cm.is_picking_close()) and buffer.pick_letter .. " "
          or " " .. buffer.devicon.icon
      end,
      fg = function(buffer)
        return (cm.is_picking_focus() and get_hex("Yellow", "fg"))
          or (cm.is_picking_close() and get_hex("Red", "fg"))
          or buffer.devicon.color
      end,
      italic = function() return (cm.is_picking_focus() or cm.is_picking_close()) end,
      bold = function() return (cm.is_picking_focus() or cm.is_picking_close()) end,
    },
    unique_prefix = {
      text = function(buffer) return buffer.unique_prefix end,
      fg = get_hex("Comment", "fg"),
      italic = true,
    },
    filename = {
      text = function(buffer) return buffer.filename .. " " end,
      underline = function(buffer) return buffer.is_hovered and not buffer.is_focused end,
    },
    diagnostics = {
      text = function(buffer)
        if buffer.diagnostics.errors ~= 0 then
          return " "
        elseif buffer.diagnostics.warnings ~= 0 then
          return " "
        else
          return ""
        end
      end,
      fg = function(buffer)
        return (buffer.diagnostics.errors ~= 0 and errors_fg)
          or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
          or nil
      end,
      truncation = { priority = 1 },
    },
    close = {
      text = function(buffer)
        if buffer.diagnostics.errors == 0 and buffer.diagnostics.warnings == 0 then
          return buffer.is_modified and "● " or " "
        else
          return ""
        end
      end,
      on_click = function(_, _, _, _, buffer) buffer:delete() end,
    },
    space = {
      text = " ",
    },
  }
  require("cokeline").setup {
    default_hl = {
      fg = function(buffer) return buffer.is_focused and "#FCDCDD" or "#859289" end,
      bg = "NONE",
    },
    buffers = {
      filter_valid = function(buffer) return buffer.type ~= "terminal" and buffer.type ~= "nofile" end,
    },
    tabs = {
      placement = "right",
      components = {
        {
          text = function(tab) return " " .. tab.number .. " " end,
          fg = function(tab) return tab.is_active and "#FCDCDD" or "#859289" end,
          bg = function(tab) return tab.is_active and "#7FBBB3" or "#859289" end,
        },
      },
    },
    ---@type Component[]
    components = {
      components.icon,
      components.unique_prefix,
      components.filename,
      components.diagnostics,
      components.close,
      components.space,
    },
  }
end
---@type LazyPluginSpec[]
return {
  {
    "willothy/nvim-cokeline",
    keys = {
      { "<leader>bd", "<Plug>(cokeline-pick-close-multiple)", desc = "pick buffer to delete" },
      { "<leader>bb", "<Plug>(cokeline-pick-focus)", desc = "pick buffer to open" },
      { "[b", "<Plug>(cokeline-focus-prev)", desc = "previous buffer" },
      { "]b", "<Plug>(cokeline-focus-next)", desc = "next buffer" },
      { "[t", "<cmd>tabp<CR>", desc = "previous tab" },
      { "]t", "<cmd>tabn<CR>", desc = "next tab" },
    },
    init = function() vim.opt.tabline = "%!v:lua.cokeline.tabline()" end,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = config,
  },
}
