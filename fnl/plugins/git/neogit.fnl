(local custom (require :custom))
{1 :NeogitOrg/neogit
 :cmd :Neogit
 :dependencies [:nvim-lua/plenary.nvim
                :sindrets/diffview.nvim
                :rcarriga/nvim-notify]
 :keys [{1 :<leader>gg 2 :<cmd>Neogit<CR> :desc "open neogit"}]
 :opts {:commit_editor {:kind :split}
        :disable_builtin_notifications true
        :disable_commit_confirmation true
        :disable_insert_on_commit false
        :integrations {:diffview true}
        :kind (if custom.prefer_tabpage :tab :split)
        :sections {:recent {:folded false} :stashes {:folded false}}}}
