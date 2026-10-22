return {
  {
    "eraserhd/parinfer-rust",
    build = "cargo build --release",
    ft = { "lisp", "clojure" },
  },
  {
    "tpope/vim-sexp-mappings-for-regular-people",
    -- enabled = false,
    ft = { "lisp", "clojure" },
    dependencies = { "guns/vim-sexp" },
    init = function()
      vim.g.sexp_enable_insert_mode_mappings = false
    end,
  },
  {
    "Olical/conjure",
    -- enabled = false,
    ft = { "lisp", "clojure" },
    init = function()
      vim.g["conjure#mapping#prefix"] = "<leader>l"
      vim.g["conjure#client#fennel#aniseed#deprecation_warning"] = false
      vim.g["conjure#extract#tree_sitter#enabled"] = true
    end,
  },
}
