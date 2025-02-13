(local config (require :nfnl.config))
(local default (config.default))

(config.default {:rtp-patterns [".*"]})
{:compiler-options {:compilerEnv _G}
 :fnl-path->lua-path (fn [path]
                       (let [config (vim.fn.stdpath :config)
                             rel-fnl-path (string.gsub path (.. "^" config) "")]
                         (default.fnl-path->lua-path (.. (vim.fn.stdpath :data)
                                                         :/nfnl rel-fnl-path))))}
