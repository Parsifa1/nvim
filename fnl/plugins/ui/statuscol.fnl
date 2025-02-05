{1 :luukvbaal/statuscol.nvim
 :event [:BufNewFile :BufReadPre]
 :opts (fn []
         (local builtin (require :statuscol.builtin))
         {:bt_ignore [:nofile :terminal]
          :ft_ignore [:leetcode.nvim]
          :segments [{:sign {:colwidth 2 :name [".*"] :text [".*"] :wrap false}}
                     {:click "v:lua.ScLa"
                      :condition [true builtin.not_empty]
                      :text [builtin.lnumfunc]}
                     {:click "v:lua.ScSa"
                      :sign {:colwidth 1 :namespace [:gitsigns] :wrap true}}
                     {:text [" "]}
                     {:click "v:lua.ScFa"
                      :text [(fn [args] (set args.fold.close "")
                               (set args.fold.open "")
                               (set args.fold.sep " ")
                               (builtin.foldfunc args))]}
                     {:text [" "]}]})}
