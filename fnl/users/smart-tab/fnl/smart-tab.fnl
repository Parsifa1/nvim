;; Provides intelligent tab behavior using treesitter

(local api vim.api)
(local notify vim.notify)

;; Default configuration
(var config {:skips [:string_content] :mapping :<tab> :exclude-filetype []})

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
  (let [(node-ok? node) (pcall vim.treesitter.get_node)]
    (if (not node-ok?)
        (do
          (notify "Treesitter not available") false)
        (let [valid-node (get-valid-node node)]
          (if (not valid-node)
              (do
                (notify "No valid parent node") false)
              (let [(row col) (valid-node:end_)
                    (move-ok?) (pcall api.nvim_win_set_cursor 0 [(+ row 1) col])]
                (if (not move-ok?)
                    (pcall api.nvim_win_set_cursor 0 [row col])
                    true)))))))

(fn setup-keymap [filetype buffer]
  "Setup smart tab keymap for buffer"
  (when (not (vim.tbl_contains config.exclude-filetype filetype))
    (let [kset vim.keymap.set
          mapping config.mapping
          feedkeys api.nvim_feedkeys
          termcodes api.nvim_replace_termcodes]
      (kset :i mapping
            (fn []
              (when (or (blank-line?) (not (smart-tab)))
                (feedkeys (termcodes mapping true true true) :n true)))
            {: buffer :desc :smart-tab}))))

(fn setup [opts]
  "Setup smart-tab plugin with optional configuration"
  (set config (vim.tbl_extend :force config (or opts {})))
  (when config.mapping
    ;; Setup autocommand for new buffers
    (let [acmd vim.api.nvim_create_autocmd
          cb :callback]
      (acmd :FileType
            {cb (fn [event]
                  (setup-keymap (. event :buf) (. event :buf)))}))
    ;; Setup for current buffer
    (setup-keymap vim.bo.filetype (api.nvim_get_current_buf))))

{: setup : smart-tab}
