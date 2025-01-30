(local config (require :nfnl.config))
(local default (config.default))

(config.default {:rtp-patterns [".*"]})
{:compiler-options {:compilerEnv _G}
 :fnl-path->lua-path (fn [fnl-path]
                       (let [rel-fnl-path (vim.fn.fnamemodify fnl-path ":.")]
                         (default.fnl-path->lua-path (.. (vim.fn.stdpath :data)
                                                         :/nfnl/ rel-fnl-path))))}
