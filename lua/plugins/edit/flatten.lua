return {
  "willothy/flatten.nvim",
  event = { "BufNewFile", "BufRead" },
  opts = {
    nest_if_no_args = true,
    window = {
      open = "alternate",
    },
  },
}
