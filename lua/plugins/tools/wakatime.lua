return {
  "wakatime/vim-wakatime",
  enabled = true,
  event = "User AfterFile",
  init = function()
    if not require("utils.function").is_windows() then
      vim.env.WAKATIME_HOME = vim.fn.expand "~/.local/share/wakatime"
    end
  end,
  opts = { status_bar_enabled = false },
}
