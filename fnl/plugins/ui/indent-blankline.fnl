{1 :lukas-reineke/indent-blankline.nvim
 :event "User AfterLoad"
 :main :ibl
 :opts {:indent {:char "│"}
        :scope {:enabled false}
        :debounce 50
        :exclude {:filetypes [:fennel]}}
 :config (fn [_ opts]
           ((. (require :ibl) :setup) opts)
           (local hooks (require :ibl.hooks))
           (hooks.register hooks.type.ACTIVE
                           (fn [_] (local unuse [:oil])
                             (not (vim.tbl_contains unuse vim.bo.filetype)))))}
