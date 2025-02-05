{1 :folke/trouble.nvim
 :cmd :Trouble
 :dependencies [:rcarriga/nvim-notify]
 :keys [{1 :<leader>q 2 "<Cmd>Trouble diagnostics <CR>" :desc :Trouble}]
 :opts {:auto_close true
        :focus true
        :keys {:<cr> :jump_close}
        :win {:size {:height 0.4 :width 0.3}}}}
