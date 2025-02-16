(local custom (require :custom))
(local opts {:defer #(match [$1.keys $1.mode]
                       ["`" _] true
                       [_ :V] true
                       [_ :<C-V>] true
                       [_ :v] true
                       _ false)
             :delay #(or (and $1.plugin 0) 200)
             :plugins {:presets {:z true}}
             :replace {:desc [["<Plug>%((.*)%)" "%1"]
                              ["^%+" ""]
                              ["<[cC]md>" ""]
                              ["<[cC][rR]>" ""]
                              ["<[sS]ilent>" ""]
                              ["^lua%s+" ""]
                              ["^call%s+" ""]
                              ["^:%s*" ""]]}
             :show_help true
             :win {:border custom.border}})

{1 :folke/which-key.nvim
 :config (fn []
           (local add (. (require :which-key) :add))
           ((. (require :which-key) :setup) opts)
           (add [{1 :<leader>c :group "Code Operations"}
                 {1 :<leader>g :group :Git}
                 {1 :<leader>s :group :Chore}
                 {1 :<leader>t :group :Telescope}
                 {1 :<leader>d :group :Dap}
                 {1 :<leader>l :group :Lisp}]))
 :event :VeryLazy}
