(let [pf :performance
      lz (. (require :lazy) :setup)
      compiled [(.. (vim.fn.stdpath :data) :/nfnl)]
      disabled [:2html_plugin
                :tohtml
                :getscript
                :getscriptPlugin
                :gzip
                :logipat
                :netrw
                :netrwPlugin
                :netrwSettings
                :netrwFileHandlers
                :matchit
                :tar
                :tarPlugin
                :rrhelper
                :spellfile_plugin
                :vimball
                :vimballPlugin
                :zip
                :zipPlugin
                :rplugin
                :syntax
                :synmenu
                :optwin
                :compiler
                :bugreport
                :ftplugin]]
  ;; lazy.nvim load
  (lz {:defaults {:lazy true}
       :diff {:cmd :browser}
       :spec [{:import :plugins}]
       :install {:colorscheme [:everforest]}
       pf {:reset_packpath true
           :cache {:enabled true}
           :throttle {:enabled true}
           :rtp {:reset true :disabled_plugins disabled :paths compiled}}
       :ui {:backdrop 100 :border :rounded}}))
