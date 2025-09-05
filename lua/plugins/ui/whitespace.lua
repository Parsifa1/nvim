---@type LazyPluginSpec
return {
  "mcauley-penney/visual-whitespace.nvim",
  -- enabled = false,
  event = "ModeChanged *:[vV\22]",
  opts = function()
    local v_bg = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
    local g_fg = vim.api.nvim_get_hl(0, { name = "Grey" }).fg
    local bg = string.format("#%06x", v_bg)
    local fg = string.format("#%06x", g_fg)
    return { highlight = { fg = fg, bg = bg } }
  end,
}
