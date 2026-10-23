local is_server = require("config.custom").is_server()

---@type LazyPluginSpec
return {
  {
    "eraserhd/parinfer-rust",
    enabled = not is_server,
    build = "cargo build --release",
    ft = { "lisp", "clojure" },
  },
  {
    "tpope/vim-sexp-mappings-for-regular-people",
    enabled = not is_server,
    ft = { "lisp", "clojure" },
    dependencies = { "guns/vim-sexp" },
    init = function()
      vim.g.sexp_enable_insert_mode_mappings = false
    end,
  },
  {
    "Olical/conjure",
    enabled = not is_server,
    ft = { "lisp", "clojure" },
    init = function()
      vim.g["conjure#mapping#prefix"] = "<leader>l"
      vim.g["conjure#client#fennel#aniseed#deprecation_warning"] = false
      vim.g["conjure#extract#tree_sitter#enabled"] = true
    end,
  },
}
