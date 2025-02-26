{1 :LeonHeidelbach/trailblazer.nvim
 :config (fn []
           (let [trail (require :trailblazer)
                 motions {:new_trail_mark :m :track_back "'"}
                 n {:actions {} : motions}
                 config {:force_mappings {: n}}]
             (trail.setup config)))
 :event "User AfterLoad"}
