local function fset(need, ...)
  local args = { ... }
  return function() require("flash")[need](unpack(args)) end
end

return {
  "folke/flash.nvim",
  event = "User AfterFile",
  opts = {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    remote = {
      remote_op = { restore = true, motion = true },
    },
    label = { uppercase = false },
    modes = {
      char = { enabled = false },
      treesitter = { highlight = { backdrop = true } },
    },
    prompt = { win_config = { border = "none" } },
  },

  keys = {
    { "s", mode = { "n", "x", "o" }, fset "jump", desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, fset("treesitter", { actions = { ["<space>"] = "next" } }) },
    { "r", mode = "o", fset "remote", desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, fset "treesitter_search", desc = "Treesitter Search" },
  },
}
