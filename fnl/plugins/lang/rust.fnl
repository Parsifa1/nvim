[{1 :mrcjkb/rustaceanvim
  :config (fn []
            (set vim.g.rustaceanvim
                 {:tools {:float_win_config {:border :rounded}
                          :test_executor :background}}))
  :ft [:rust]
  :version :^4}
 ;; crates
 {1 :saecki/crates.nvim
  :config (fn []
            ((. (require :crates) :setup)))
  :event ["BufRead Cargo.toml"]
  :tag :stable}]
