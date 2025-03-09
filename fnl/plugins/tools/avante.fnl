{1 :yetone/avante.nvim
 :build :make
 :dependencies [:stevearc/dressing.nvim
                :nvim-lua/plenary.nvim
                :MunifTanjim/nui.nvim
                :echasnovski/mini.icons
                :zbirenbaum/copilot.lua]
 :keys [{1 :<leader>aa
         2 (fn []
             ((. (require :avante.api) :ask)))
         :desc "avante: ask"
         :mode [:n :v]}
        {1 :<leader>ar
         2 (fn []
             ((. (require :avante.api) :refresh)))
         :desc "avante: refresh"}
        {1 :<leader>ae
         2 (fn []
             ((. (require :avante.api) :edit)))
         :desc "avante: edit"
         :mode :v}]
 :opts {:copilot {:model :claude-3.5-sonnet}
        :hints {:enabled false}
        :provider :copilot}}
