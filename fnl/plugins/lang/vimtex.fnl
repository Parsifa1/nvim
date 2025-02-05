{1 :lervag/vimtex
 :enabled (= (. (vim.uv.os_uname) :sysname) :Windows_NT)
 :ft [:tex]
 :init (fn [] (set vim.g.vimtex_view_method :zathura))}
