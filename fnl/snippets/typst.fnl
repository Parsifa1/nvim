(local ls (require :luasnip))
(local f ls.function_node)
(local pf (. (require :luasnip.extras.postfix) :postfix))

[(pf :.bold [(f (fn [_ parent]
                  (.. "bold(" parent.snippet.env.POSTFIX_MATCH ")"))
                {})])]
