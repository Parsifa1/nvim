{1 :kylechui/nvim-surround
   :event "User AfterLoad"  
   :config (fn []
             ((. (require :nvim-surround) :setup) {}))}
