{1 :skywind3000/asynctasks.vim
 :dependencies [:skywind3000/asyncrun.vim]
 :event "User AfterLoad"
 :ft [:cpp :python]
 :init (fn [] (set vim.g.asynctasks_term_pos :toggleterm))}  
