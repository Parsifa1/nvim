(local ivy {:fzf_opts {:--layout :reverse :--marker "+"}
            :header false
            :hls {:border :TelescopeBorder
                  :cursor :Cursor
                  :cursorline :TelescopeSelection
                  :cursorlinenr :TelescopeSelection
                  :help_border :TelescopeBorder
                  :help_normal :TelescopeNormal
                  :normal :TelescopeNormal
                  :preview_border :TelescopeBorder
                  :preview_normal :TelescopeNormal
                  :preview_title :TelescopePreviewTitle
                  :search :IncSearch
                  :title :TelescopePromptTitle}
            :previewers {:builtin {:toggle_behavior :extend}}
            :winopts {:backdrop false
                      :height 25
                      :preview {:flip_columns 120
                                :hidden :nohidden
                                :horizontal "right:50%"
                                :layout :flex
                                :scrollbar false}
                      :row 1
                      :width 1}})

(fn keys []
  (if (not= (. (vim.uv.os_uname) :sysname) :Windows_NT)
      [{1 :<esc> 2 :<c-c> :ft :fzf :mode :t :nowait true}
       {1 :<leader>f 2 "<cmd>FzfLua files<CR>" :desc "find files"}
       {1 :<leader>r 2 "<cmd>FzfLua oldfiles<CR>" :desc "recent files"}
       {1 :<leader>w 2 "<cmd>FzfLua live_grep<CR>" :desc "live grep"}
       {1 :<leader>tc 2 "<cmd>FzfLua commands<CR>" :desc "Fzflua Commands"}
       {1 :<leader>tk 2 "<cmd>FzfLua keymaps<CR>" :desc "Fzflua Keymaps"}
       {1 :<leader>tl 2 "<cmd>FzfLua highlights<CR>" :desc "Fzflua Highlights"}
       {1 :<leader>th 2 "<cmd>FzfLua helptags<CR>" :desc "Fzflua Help"}]
      [{1 :<esc> 2 :<c-c> :ft :fzf :mode :t :nowait true}]))

(fn merge [x] (vim.tbl_extend :force ivy x))

(local fd_opts (.. "-H -I "
                   "-E '{.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target,.orbstack,.cache,.rustup,.wakatime,.compiled}' "
                   "--type f --strip-cwd-prefix"))

(local rg_opts
       (.. "--no-heading --line-number " "--column --smart-case --hidden "
           "--glob '!{.git,node_modules,package-lock.json,pnpm-lock.yaml,yarn.lock,.vscode-server,.virtualenvs,target,.orbstack,.cache,.vscode,.rustup.wakatime,.compiled}' "))

{1 :ibhagwan/fzf-lua
 :cmd :FzfLua
 :dependencies [:echasnovski/mini.icons :moonbit-community/moonbit.nvim]
 :enabled true
 :keys (keys)
 :opts {1 :default-title
        :oldfiles ivy
        :grep {: rg_opts}
        :files (merge {: fd_opts :git_icons false})
        :winopts {:backdrop false :preview {:delay 50}}
        :keymap {:fzf {:ctrl-d :half-page-down :ctrl-u :half-page-up}}}}
