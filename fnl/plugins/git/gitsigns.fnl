{1 :lewis6991/gitsigns.nvim
 :config (fn []
           (local gitsigns (require :gitsigns))
           (gitsigns.setup {:current_line_blame true
                            :signcolumn true
                            :signs {:add {:text "┃"}
                                    :change {:text "┃"}
                                    :changedelete {:text ""}
                                    :delete {:text ""}
                                    :topdelete {:text ""}
                                    :untracked {:text "▏"}}})

           (fn set-hl []
             (vim.api.nvim_set_hl 0 :GitSignsChangeLn {:link :DiffText})
             (vim.api.nvim_set_hl 0 :GitSignsDeleteLn {:link :DiffDelete})
             (vim.api.nvim_set_hl 0 :GitSignsAddInline {:link :GitSignsAddLn})
             (vim.api.nvim_set_hl 0 :GitSignsDeleteInline
                                  {:link :GitSignsDeleteLn})
             (vim.api.nvim_set_hl 0 :GitSignsChangeInline
                                  {:link :GitSignsChangeLn}))

           (set-hl)
           (vim.api.nvim_create_autocmd :ColorScheme
                                        {:callback set-hl
                                         :desc "Set gitsigns highlights"}))
 :dependencies :nvim-lua/plenary.nvim
 :event "User AfterLoad"
 :keys [{1 :<leader>gb 2 "<Cmd>Gitsigns blame_line<CR>" :desc "gitsigns blame"}
        {1 :<leader>gp
         2 "<Cmd>Gitsigns preview_hunk<CR>"
         :desc "gitsigns hunk preview"}]}
