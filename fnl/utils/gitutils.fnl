(local M {})

;; Type annotation for git-cache table<string, boolean>
(var git-cache {})

(fn is-git-root [dir]
  (when (= nil (. git-cache dir))
    (let [uv (or vim.uv vim.loop)]
      (tset git-cache dir (not= nil (uv.fs_stat (.. dir "/.git"))))))
  (. git-cache dir))

;; Gets the git root for a buffer or path
;; Defaults to the current buffer
;; @param path? number|string buffer or path
(fn get-root [?path]
  (let [path (if ?path ?path 0)
        norm-path (if (= :number (type path))
                     (vim.api.nvim_buf_get_name path)
                     path)
        path* (vim.fs.normalize norm-path)
        uv (or vim.uv vim.loop)
        final-path (if (= path* "")
                      (.. (uv.cwd) "/foo")
                      path*)]
    ;; check cache first
    (var result nil)
    (each [dir (vim.fs.parents final-path) &until result]
      (when (. git-cache dir)
        (set result (vim.fs.normalize dir))))
    
    (when (not result)
      (each [dir (vim.fs.parents final-path) &until result]
        (when (is-git-root dir)
          (set result (vim.fs.normalize dir)))))
    
    result))

(tset M :get_root get-root)

M
