(local formatters
       {:clang_format {:command :clang-format}
        :prettier {:prepend_args ["--tab-width 2"]}})

(local format_ft {:astro [:prettier]
                  :cpp [:clang_format]
                  :css [:prettier]
                  :fennel [:fnlfmt]
                  :haskell [:fourmolu]
                  :html [:prettier]
                  :javascript [:prettier]
                  :javascriptreact [:prettier]
                  :lua [:stylua]
                  :markdown [:prettier]
                  :nix [:nixfmt]
                  :python [:ruff_fix :ruff_format]
                  :rust [:rustfmt]
                  :typescript [:prettier]
                  :typescriptreact [:prettier]
                  :typst [:typstyle]
                  :yaml [:prettier]})

{1 :stevearc/conform.nvim
 :cmd :ConformInfo
 :config (fn []
           ((. (require :conform) :setup) {: formatters
                                           :formatters_by_ft format_ft})
           (set vim.o.formatexpr "v:lua.require'conform'.formatexpr()")
           (set vim.o.formatprg "v:lua.require'conform'.formatprg()"))
 :keys [{1 :<leader>F
         2 (fn []
             ((. (require :conform) :format) {:lsp_format :fallback}))
         :desc "Format Document"
         :mode [:n :v]}]}
