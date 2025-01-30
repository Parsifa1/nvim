(fn flash-set [need]
  (fn []
    ((. (require :flash) need))))

{1 :folke/flash.nvim
 :event "User AfterLoad"
 :keys [{1 :s 2 (flash-set :jump) :desc :Flash :mode [:n :x :o]}
        {1 :S
         2 (flash-set :treesitter)
         :desc "Flash Treesitter"
         :mode [:n :x :o]}
        {1 :r 2 (flash-set :remote) :desc "Remote Flash" :mode :o}
        {1 :R
         2 (flash-set :treesitter_search)
         :desc "Treesitter Search"
         :mode [:o :x]}]
 :opts {:label {:uppercase false}
        :labels :asdfghjklqwertyuiopzxcvbnm
        :modes {:char {:enabled false}
                :treesitter {:highlight {:backdrop true}}}
        :remote {:remote_op {:motion true :restore true}}}}  
