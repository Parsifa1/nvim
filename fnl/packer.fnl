(when vim.env.PROF
  (local snacks (.. (vim.fn.stdpath :data) :/lazy/snacks.nvim))
  (vim.opt.rtp:append snacks)
  ((. (require :snacks.profiler) :startup) {:startup {:event :VimEnter}}))

(vim.loader.enable)
(set vim.g.mapleader " ")
(set vim.g.maplocalleader " ")
(local lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim))
(when (not (vim.uv.fs_stat lazypath))
  (let [sys vim.fn.system
        url [:git
             :clone
             "--filter=blob:none"
             "https://github.com/folke/lazy.nvim.git"
             :--branch=stable
             lazypath]]
    (sys url)))

(vim.opt.rtp:prepend lazypath)

(let [pf :performance
      lz (. (require :lazy) :setup)
      compiled [(.. (vim.fn.stdpath :config) :/.compiled)]
      dp [:2html_plugin
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
           :rtp {:reset true :disabled_plugins dp :paths compiled}}
       :ui {:backdrop 100 :border :rounded}}))
