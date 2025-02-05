(local config (require :nfnl.config))
(local default (config.default))

(config.default {:rtp-patterns [".*"]})
{:compiler-options {:compilerEnv _G}
 :fnl-path->lua-path (fn [path]
                       (let [modify vim.fn.fnamemodify
                             config (vim.fn.stdpath :config)
                             rel-fnl-path (modify path (.. ":s?^" config "/??"))]
                         (default.fnl-path->lua-path (.. (vim.fn.stdpath :data)
                                                         :/nfnl/ rel-fnl-path))))}
