{1 :ruifm/gitlinker.nvim
 :dependencies :nvim-lua/plenary.nvim
 :keys [{1 :<leader>gy
         2 (fn []
             ((. (require :gitlinker) :get_buf_range_url) :n))
         :desc "Create link"}
        {1 :<leader>gy
         2 (fn []
             ((. (require :gitlinker) :get_buf_range_url) :v))
         :desc "Create link"
         :mode :v}]
 :opts {:mappings nil}}
