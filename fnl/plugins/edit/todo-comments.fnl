{1 :folke/todo-comments.nvim
 :config (fn []
           ((. (require :todo-comments) :setup) {:signs true}))
 :event "User AfterLoad"}  
;; BUG: do not have SIGNS}

