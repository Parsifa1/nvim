local function flash_set(need)
  return function() require("flash")[need]() end
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
    { "s", mode = { "n", "x", "o" }, flash_set "jump", desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, flash_set "treesitter", desc = "Flash Treesitter" },
    { "r", mode = "o", flash_set "remote", desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, flash_set "treesitter_search", desc = "Treesitter Search" },
  },
}
