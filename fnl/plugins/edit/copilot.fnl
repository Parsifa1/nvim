(local kset vim.api.nvim_set_keymap)

{1 :github/copilot.vim
 :config (fn []
           (kset :i :<C-CR> "copilot#Accept(\"<CR>\")"
                                    {:expr true :silent true}))
 :event [:BufNewFile :BufReadPost]}  
