{1 :hiphish/rainbow-delimiters.nvim
 :config (fn []
           (local rainbow-delimiters (require :rainbow-delimiters))
           (local setup (. rainbow-delimiters :setup))
           (setup {:highlight [:RainbowDelimiterRed
                               :RainbowDelimiterYellow
                               :RainbowDelimiterBlue
                               :RainbowDelimiterOrange
                               :RainbowDelimiterGreen
                               :RainbowDelimiterViolet
                               :RainbowDelimiterCyan]
                   :priority {"" 110 :lua 210}
                   :query {"" :rainbow-delimiters :lua :rainbow-blocks}
                   :strategy {"" (. rainbow-delimiters.strategy :global)
                              :vim (. rainbow-delimiters.strategy :local)}}))
 :enabled false
 :event "User AfterLoad"}
