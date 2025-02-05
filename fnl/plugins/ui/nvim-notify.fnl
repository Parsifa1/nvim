{1 :rcarriga/nvim-notify
 :config (fn []
           (local notify (. (require :notify) :setup))
           (notify {:on_open (fn [win]
                               (vim.api.nvim_win_set_config win
                                                            {:focusable false}))
                    :render :wrapped-compact
                    :stages :fade}))
 :event "User AfterLoad"
 :init (fn []
         (fn vim.notify [...]
           (when (not (. (require :lazy.core.config) :plugins :nvim-notify "_"
                         :loaded))
             ((. (require :lazy) :load) [:nvim-notify]))
           ((require :notify) ...)))}
