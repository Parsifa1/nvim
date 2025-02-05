(local custom (require :custom))
(local opts {:defer (fn [ctx]
                      (or (or (or (= ctx.keys "`") (= ctx.mode :V))
                              (= ctx.mode :<C-V>))
                          (= ctx.mode :v)))
             :delay (fn [ctx] (or (and ctx.plugin 0) 200))
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
           ((. (require :which-key) :setup) opts)
           ((. (require :which-key) :add) [{1 :<leader>c
                                            :group "Code Operations"}
                                           {1 :<leader>g :group :Git}
                                           {1 :<leader>s :group :Chore}
                                           {1 :<leader>t :group :Telescope}
                                           {1 :<leader>d :group :Dap}
                                           {1 :<leader>l :group :Lisp}]))
 :event :VeryLazy}  
