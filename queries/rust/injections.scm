;extend
; A general query injection
; Adapted from
;  https://github.com/ray-x/go.nvim/blob/master/after/queries/go/injections.scm

((string_content) @injection.content
(#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?|(CREATE|create|DROP|drop|ALTER|alter|TRUNCATE|truncate).+(TABLE|table|INDEX|index|DATABASE|database|VIEW|view|SEQUENCE|sequence)")
(#set! injection.language "sql")
(#set! injection.include-children)
)

