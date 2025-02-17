;; [nfnl-macro]
(fn init [tbl ...]
  (let [args [...]
        n (length args)]
    (if (and (= n 1) (= (type (. args 1)) :table))
        (let [value (. args 1)]
          `(do
             (each [k# v# (pairs ,value)]
               (tset ,tbl k# v#))
             ,tbl))
        (let [keys (fcollect [i 1 (- n 1)] (. args i))
              value (. args n)]
          (fn build-path [path depth]
            (if (= depth (length keys))
                `(if (= (. ,path ,(. keys depth)) nil)
                     (tset ,path ,(. keys depth) ,value))
                `(do
                   (if (= (. ,path ,(. keys depth)) nil)
                       (tset ,path ,(. keys depth) {}))
                   ,(build-path `(. ,path ,(. keys depth)) (+ depth 1)))))

          `(do
             ,(build-path tbl 1)
             (. ,tbl ,(unpack keys)))))))

(fn set-hl [...]
  `(vim.api.nvim_set_hl 0 ,...))

{: init : set-hl}
