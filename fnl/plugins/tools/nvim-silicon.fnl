{1 :michaelrommel/nvim-silicon
 :cmd :Silicon
 :enabled (not= (vim.fn.hostname) :debian)
 :keys [{1 :<leader>sc
         2 (fn []
             ((. (require :nvim-silicon) :clip)))
         :desc "Copy code screenshot to clipboard"
         :mode [:n :v]}]
 :main :nvim-silicon
 :opts {:font "IosevkaCloudtide Nerd Font; LXGW WenKai"
        :line_offset (fn [args] args.line1)
        :wslclipboard :auto}}
