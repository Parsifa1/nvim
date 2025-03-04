{1 :smart-tab
 :event :InsertEnter
 :dir (.. (vim.fn.stdpath :data) :/nfnl/lua/users/smart-tab)
 :config (fn []
           ((. (require :smart-tab) :setup) {:skips [:string_content]
                                             :mapping :<tab>
                                             :backward-mapping :<S-Tab>
                                             :exclude_filetypes []}))}
