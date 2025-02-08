(fn flash [prompt-bufnr]
  (let [jump (. (require :flash) :jump)]
    (jump {:action (fn [mat]
                     (local picker
                            ((. (require :telescope.actions.state)
                                :get_current_picker) prompt-bufnr))
                     (picker:set_selection (- (. mat.pos 1) 1)))
           :label {:after [0 0]}
           :pattern "^"
           :search {:exclude [(fn [win]
                                (not= (. vim.bo (vim.api.nvim_win_get_buf win)
                                         :filetype)
                                      :TelescopeResults))]
                    :mode :search}})))

(local opts {:defaults {:color_devicons true
                        :layout_config {:horizontal {:height_padding 0.1
                                                     :preview_height 0.5
                                                     :preview_width 0.5
                                                     :width_padding 0.1}
                                        :vertical {:height_padding 1
                                                   :preview_height 0.5
                                                   :width_padding 0.05}}
                        :mappings {:i {:<A-q> :close
                                       :<C-f> :to_fuzzy_refine
                                       :<C-j> :move_selection_next
                                       :<C-k> :move_selection_previous
                                       :<C-s> flash
                                       :<esc> :close}
                                   :n {:<A-q> :close
                                       :<C-f> :to_fuzzy_refine
                                       :<C-s> flash
                                       :q :close
                                       :s flash
                                       :zh :select_horizontal
                                       :zv :select_vertical}}
                        :prompt_prefix "❯ "
                        :selection_caret "  "}
             :extensions {:fzy_native {:override_file_sorter true
                                       :override_generic_sorter false}}
             :pickers {:buffers {:ignore_current_buffer true
                                 :initial_mode :normal
                                 :mappings {:n {:dd :delete_buffer}}
                                 :path_display [:smart]
                                 :previewer false
                                 :theme :dropdown}
                       :find_files {:find_command [:fd
                                                   :-H
                                                   :-I
                                                   :--type
                                                   :f
                                                   "--exclude={.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target}"
                                                   :--strip-cwd-prefix]
                                    :theme :ivy}
                       :git_files {:theme :ivy}
                       :help_tags {:layout_config {:prompt_position :top}
                                   :layout_strategy :horizontal
                                   :sorting_strategy :ascending}
                       :highlights {:layout_config {:prompt_position :top}
                                    :layout_strategy :horizontal
                                    :sorting_strategy :ascending}
                       :live_grep {:layout_config {:prompt_position :top}
                                   :layout_strategy :horizontal
                                   :sorting_strategy :ascending
                                   :vimgrep_arguments [:rg
                                                       :--no-heading
                                                       :--line-number
                                                       :--column
                                                       :--smart-case
                                                       :--hidden
                                                       :--glob
                                                       "!{**/.git/*,**/node_modules/*,**/package-lock.json,pnpm-lock.yaml,**/yarn.lock,.vscode-server,.virtualenvs}"]}
                       :oldfiles {:theme :ivy}}})

(fn keys []
  (if (= (. (vim.uv.os_uname) :sysname) :Windows_NT)
      [{1 :<Tab><Tab> 2 "<cmd>Telescope buffers<CR>" :desc :buffers}
       {1 :<leader>tc
        2 "<cmd>Telescope commands<CR>"
        :desc "telescope commands"}
       {1 :<leader>tk 2 "<cmd>Telescope keymaps<CR>" :desc "telescope keymaps"}
       {1 :<leader>tl
        2 "<cmd>Telescope highlights<CR>"
        :desc "telescope highlights"}
       {1 :<leader>th
        2 "<cmd>Telescope help_tags<CR>"
        :desc "telescope highlights"}
       {1 :<leader>f 2 "<cmd>Telescope find_files<CR>" :desc "find files"}
       {1 :<leader>w 2 "<cmd>Telescope live_grep<CR>" :desc "live grep"}
       {1 :<leader>r 2 "<cmd>Telescope oldfiles<CR>" :desc "recent files"}]
      [{1 :<Tab><Tab> 2 "<cmd>Telescope buffers<CR>" :desc :buffers}]))

(local tele-luasnip {1 :benfowler/telescope-luasnip.nvim
                     :config (fn []
                               ((. (require :telescope) :load_extension) :luasnip))
                     :keys [{1 :<leader>ts
                             2 "<cmd>Telescope luasnip theme=ivy<CR>"
                             :desc "telescope luasnip"}]})

(local telescope {1 :nvim-telescope/telescope.nvim
                  :branch :0.1.x
                  :cmd :Telescope
                  :config (fn []
                            ((. (require :telescope) :setup) opts)
                            ((. (require :telescope) :load_extension) :fzf))
                  :dependencies [:nvim-lua/popup.nvim
                                 :rcarriga/nvim-notify
                                 {1 :nvim-telescope/telescope-fzf-native.nvim
                                  :build :make}]
                  :keys (keys)
                  : opts})

[tele-luasnip telescope]
