[{1 :eraserhd/parinfer-rust :build "cargo build --release" :ft :fennel}
 {1 :tpope/vim-sexp-mappings-for-regular-people
  :ft :fennel
  :dependencies [:guns/vim-sexp]
  :init (fn [] (set vim.g.exp_enable_insert_mode_mappings false))}
 {1 :Olical/conjure
  :ft :fennel
  :init (fn [] (set vim.g.conjure#mapping#prefix :gh)
          (set vim.g.conjure#client#fennel#aniseed#deprecation_warning false))}]
