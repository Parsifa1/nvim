return {
  "folke/todo-comments.nvim",
  event = "User AfterFile",
  config = function()
    require("todo-comments").setup {
      signs = true,
    }
  end,
  --BUG: do not have SIGNS
}
