;; Provides intelligent tab behavior using treesitter

(local api vim.api)
(local notify vim.notify)

;; Default configuration
(var config {:skips [:string_content]
             :mapping :<tab>
             :backward-mapping :<S-Tab>
             :exclude-filetype []})

;; Stack to store cursor positions before tab jumps
(var position-history [])

(fn blank-line? []
  "Check if current line up to cursor is only whitespace"
  (let [(line col) (unpack (api.nvim_win_get_cursor 0))
        current-line (. (api.nvim_buf_get_lines 0 (- line 1) line true) 1)
        left-of-cursor (string.sub current-line 1 col)]
    (not= nil (string.match left-of-cursor "^%s*$"))))

(fn should-skip? [node-type]
  "Determine if a treesitter node type should be skipped"
  (accumulate [should-skip false _ skip (ipairs config.skips)]
    (if should-skip true
        (match (type skip)
          :string (= skip node-type)
          :function (skip node-type)
          _ false))))

(fn get-valid-node [node]
  "Get first valid parent node that shouldn't be skipped"
  (if (or (not node) (not (should-skip? (node:type))))
      node
      (get-valid-node (node:parent))))

(fn smart-tab []
  "Main smart tab implementation"
  (let [(node-ok? node) (pcall vim.treesitter.get_node)
        valid-node (get-valid-node node)
        current-pos (api.nvim_win_get_cursor 0)
        (row col) (valid-node:end_)
        (move-ok?) (pcall api.nvim_win_set_cursor 0 [(+ row 1) col])]
    (if (not node-ok?) (notify "Treesitter not available")
        ;; If no valid parent node found, notify user
        (not valid-node) (notify "No valid parent node"))
    ;; Only save position history if we actually moved
    (when move-ok? (table.insert position-history current-pos))
    (if (not move-ok?) (pcall api.nvim_win_set_cursor 0 [row col]) true)))

(fn smart-tab-backward []
  "Jump back to the previous cursor position"
  (if (= (length position-history) 0)
      (notify "No previous position to jump to" vim.log.levels.INFO)
      (let [prev-pos (table.remove position-history)
            (move-ok?) (pcall api.nvim_win_set_cursor 0 prev-pos)]
        move-ok?)))

(fn setup-keymap [filetype buffer]
  "Setup smart tab keymap for buffer"
  (when (not (vim.tbl_contains config.exclude-filetype filetype))
    (let [kset vim.keymap.set
          mapping config.mapping
          backward-mapping config.backward-mapping
          feedkeys api.nvim_feedkeys
          termcodes api.nvim_replace_termcodes]
      ;; Setup forward tab mapping
      (kset :i mapping
            #(when (or (blank-line?) (not (smart-tab)))
               (feedkeys (termcodes mapping true true true) :n true))
            {: buffer :desc :smart-tab})
      ;; Setup backward tab mapping
      (when backward-mapping
        (kset :i backward-mapping
              #(when (not (smart-tab-backward))
                 (feedkeys (termcodes backward-mapping true true true) :n true))
              {: buffer :desc :smart-tab-backward})))))

(fn clear-position-history []
  "Clear the position history stack"
  (set position-history []))

(fn setup [opts]
  "Setup smart-tab plugin with optional configuration"
  (set config (vim.tbl_extend :force config (or opts {})))
  (when config.mapping
    (let [autocmd vim.api.nvim_create_autocmd
          call :callback]
      (autocmd :FileType {call #(setup-keymap (. $1 :buf) (. $1 :buf))})
      (autocmd :ModeChanged {call #(clear-position-history) :pattern "*:n"}))
    (setup-keymap vim.bo.filetype (api.nvim_get_current_buf))))

{: setup : smart-tab : smart-tab-backward : clear-position-history}
