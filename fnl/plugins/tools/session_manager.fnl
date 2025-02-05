{1 :Shatur/neovim-session-manager
 :config (fn []
           (local session (. (require :session_manager) :setup))
           (session {:autoload_mode (. (require :session_manager.config)
                                       :AutoloadMode :CurrentDir)
                     :autosave_ignore_buftypes [:terminal]
                     :autosave_ignore_filetypes [:gitcommit
                                                 :gitrebase
                                                 :toggleterm
                                                 :help
                                                 :lazy
                                                 :Avante
                                                 :AvanteInput]
                     :autosave_only_in_session true}))
 :dependencies [:stevearc/dressing.nvim :nvim-lua/plenary.nvim]
 :keys [{1 :<leader><Tab>
         2 "<cmd>SessionManager load_session<CR><esc>"
         :desc "projects folder"}
        {1 :<leader>i
         2 "<cmd>SessionManager load_session<CR><esc>"
         :desc "projects folder"}]
 :lazy false}
