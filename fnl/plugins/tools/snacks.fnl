(local get-root (. (require :utils.gitutils) :get_root))

;; dashboard func
(fn get-session-dirs []
  (let [sessions (require :session_manager.utils)
        dirs {}]
    (each [_ item (ipairs (sessions.get_sessions))]
      (tset dirs (: (. item.dir :filename) :gsub "\\" "/") true))
    dirs))

(fn create-seen-filter []
  (let [seen {}]
    (fn [dir]
      (if (. seen dir) false
          (do
            (tset seen dir true) true)))))

(fn get-mapped-file [session-dirs file]
  (if (not (vim.uv.fs_stat file))
      nil
      (let [git-root (get-root file)]
        (var result nil)
        ;; Check session directories
        (each [session-dir _ (pairs session-dirs)]
          (let [session-symbol (string.sub file (+ (length session-dir) 1)
                                           (+ (length session-dir) 1))]
            (when (and (vim.startswith file session-dir) (= session-symbol "/"))
              (set result session-dir))))
        ;; Check git root
        (when (and git-root (vim.startswith file git-root))
          (set result git-root))
        ;; Default to file's directory
        (or result (vim.fs.dirname file)))))

(fn map-windows-path [path]
  (if (path:match "^[A-Z]:/")
      (: path :gsub "/" "\\")
      path))

(fn dirs []
  (let [session-dirs (get-session-dirs)
        seen-filter (create-seen-filter)
        normalized-files (vim.tbl_map vim.fs.normalize vim.v.oldfiles)
        mapped-files (vim.tbl_map #(get-mapped-file session-dirs $1)
                                  normalized-files)
        filtered-files (vim.tbl_filter seen-filter mapped-files)
        windows-paths (vim.tbl_map map-windows-path filtered-files)]
    windows-paths))

;; ascii anime header
(local header
       "
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡤⠤⢤⡤⠴⢤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡴⣞⣋⡁⣠⡤⢴⣋⡠⢄⣀⠀⠈⠛⠷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⡿⣟⠽⠛⢛⡜⣱⡞⠉⢮⡉⠑⢮⣑⢦⡀⠀⠈⠻⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⡏⢘⠁⢀⣴⡟⢁⡇⡇⠀⠈⢿⣦⠀⠙⣷⡙⢦⡀⠀⠸⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣏⠔⠁⣠⠊⣾⡇⢸⠁⣇⠀⠀⠘⣧⢃⠀⠘⣷⠈⢻⣆⠀⢹⡆⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⢟⡏⠀⡰⢣⢾⣿⠀⢸⠀⣿⠀⠀⠀⢿⡞⡆⠀⣿⣇⠈⢻⣆⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠇⡾⠀⢰⣷⠧⢺⢹⠀⢸⡀⠸⡇⠀⠀⠘⡇⢡⠀⢸⣽⡀⠈⣿⡀⣿⡀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣼⣻⠀⣿⠃⠀⠀⣿⡆⢸⣧⠀⢻⡉⠙⠒⢷⣸⠀⢸⣌⣧⡀⣾⣧⣯⣗⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⡇⢀⣯⣷⣶⣶⡿⣷⡘⣿⣆⡈⢿⣤⣆⠸⢸⠂⠀⣿⣼⣽⣿⡇⡏⢻⣇⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣧⠈⡿⡸⣿⣿⣿⠍⠛⠛⠉⢹⣿⣿⣿⢿⣿⣀⣠⣷⣿⢿⣵⣤⡇⢠⣿⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣷⣽⣔⠙⠒⠋⠀⠀⠀⠀⠀⠿⣉⣿⠃⡝⢡⣿⣿⡿⣸⣿⣄⣰⣿⠋⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠿⢛⡿⢹⣧⢸⢻⡏⠁⠀⠀⠀⠀⠀⠀⠀⢠⠀⣠⣾⣷⣿⢿⣿⣧⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⣠⣾⠁⣸⡇⡿⡿⣷⣄⠀⠀⠀⢠⡀⠀⠀⠀⠀⠀⣸⣇⡞⣿⣿⣿⡙⣿⢸⣿⢿⢿⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⢰⣿⡿⢻⢞⡽⣱⡾⣼⣿⣿⣿⣦⡀⠀⠀⠀⠀⣀⡤⠀⣟⡟⢠⣇⣻⡏⣇⣿⡀⣿⢾⣿⠀⠀⠀⠀⠀⠀
      ⠀⠀⢀⣴⠟⡱⠀⢀⣾⢟⣿⣿⣿⣿⣿⡟⠛⠉⢩⠿⠛⠀⠀⢀⣼⡟⢡⣾⣿⠟⢿⣿⣆⢹⣿⢸⣿⠈⣿⡄⠀⠀⠀⠀
      ⠀⡴⢻⣋⡞⡤⢶⣿⠏⣾⣿⣿⣿⣿⡿⠀⠀⢀⣿⣿⣷⣤⣠⣾⡿⣠⣿⡟⠁⣀⣠⣽⣿⡄⠈⠻⢿⡀⠙⣿⢦⡀⠀⠀
      ⢰⣧⡿⣿⠀⢠⣾⡇⣸⣿⡟⢡⣯⡿⣇⠀⠀⣸⠇⠀⠹⣿⣿⣿⣠⣿⣿⣷⣾⣿⣿⢿⢿⣿⣆⢣⠀⢻⣤⡸⡌⢿⡄⠀
      ⠸⣿⣧⢿⠷⣎⣿⠁⣿⡿⠃⠈⣿⢷⣿⡀⠀⡟⠀⣠⠞⣵⡿⢡⣿⣿⣿⣿⢛⣿⣷⣧⡞⠀⢹⣼⡇⢹⢿⡿⣿⠀⢿⡄
      ⠀⠀⢹⡞⣤⣿⣿⣆⣿⣷⣴⣾⠁⠈⢿⣧⢠⣧⠞⠁⠀⣿⠇⢸⡿⠟⢡⡇⣸⡟⣿⣿⣿⠀⠀⢿⡇⠰⣿⡇⢹⠀⣸⡇
      ⠀⠀⠘⠛⠙⣽⣿⣿⠟⢻⡾⠛⢯⡀⣼⣿⣾⣯⣶⣾⣿⠿⣶⣽⡦⠀⡜⢠⡟⠹⢿⣿⠈⣇⠀⢸⣧⣸⣿⠁⣸⣴⡿⠁
      ⠀⠀⠀⠀⣴⠟⣿⢋⣤⣾⠃⠀⠀⣹⢟⣿⠉⣹⣿⣍⡁⠀⠀⣀⡥⠞⠁⠈⠀⢧⠀⠻⠂⠙⠀⠀⢹⡗⠃⠈⠉⠈⠁⠀
      ⠀⠀⠀⠀⠀⣸⣿⣿⣫⠇⠀⣠⠞⣱⠛⣿⣿⢿⠹⡇⠀⣯⠉⠁⠀⠀⠀⠀⠀⢺⠀⠀⠀⠀⠀⠀⠈⣿⠀⠀⠀⠀⠀⠀")

(local ivy {:layout {:backdrop false
                     :box :horizontal
                     :row -1
                     :height 26
                     1 {:box :vertical
                        :border :none
                        :title "{title} {live} {flags}"
                        1 {:win :input :height 1 :border :rounded}
                        2 {:win :list :border :rounded}}
                     2 {:win :preview
                        :title "{preview}"
                        :border :rounded
                        :width 0.5}}})

(local select {:layout {:backdrop false
                        :border :rounded
                        :box :vertical
                        :height 0.35
                        :min_height 12
                        :min_width 65
                        :title "{title}"
                        :title_pos :center
                        :width 0.47
                        1 {:border :bottom :height 1 :win :input}
                        2 {:border :none :win :list}
                        3 {:border :top
                           :height 0.4
                           :title "{preview}"
                           :win :preview}}
               :preview false})

(fn keys []
  (let [snack #(.. "<cmd>lua Snacks.picker." $1 "()<CR>")]
    (if (= (. (vim.uv.os_uname) :sysname) :Windows_NT)
        [{1 :<leader>tc 2 (snack :commands) :desc "commands picker"}
         {1 :<leader>tk 2 (snack :keymaps) :desc "keymaps picker"}
         {1 :<leader>tl 2 (snack :highlights) :desc "highlights picker"}
         {1 :<leader>th 2 (snack :help) :desc "help picker"}
         {1 :<leader>f 2 (snack :smart) :desc "find files"}
         {1 :<leader>r 2 (snack :recent) :desc "recent files"}
         {1 :<leader>w 2 (snack :grep) :desc "live grep"}
         {1 :<tab><tab> 2 (snack :buffers) :desc :buffers}]
        [{1 :<tab><tab> 2 (snack :buffers) :desc :buffers}])))

{1 :folke/snacks.nvim
 :lazy false
 :keys (keys)
 :priority 1000
 :opts {:quickfile {}
        :words {:debounce 100}
        :bigfile {:enabled true
                  :notify true
                  :setup (fn [ctx]
                           (vim.cmd :NoMatchParen)
                           (set vim.b.minianimate_disable true)
                           (let [wo (. (require :snacks) :util :wo)]
                             (wo 0 {:conceallevel 0 :foldmethod :manual}))
                           (vim.schedule #(tset (. vim.bo ctx.buf) :syntax
                                                ctx.ft)))
                  :size (* 1024 1024 1.5)}
        :picker {:image {}
                 :ui_select false
                 :layouts {: ivy : select}
                 :layout {:preset #(let [ok #(match $1
                                               :smart :ivy
                                               :files :ivy
                                               :recent :ivy
                                               :buffers :dropdown
                                               _ :default)]
                                     (if (< vim.o.columns 90) :vertical
                                         (ok $1)))
                          :layout {:backdrop false}}
                 :win {:input {:keys {:<Esc> {1 :close :mode [:n :i]}}}}
                 :sources {:buffers {:on_show #(vim.cmd :stopinsert)}}}
        :dashboard {:preset {:keys [{:action "<cmd>FzfLua files<CR>"
                                     :desc "Find file"
                                     :icon " "
                                     :key :f}
                                    {:action "<cmd>FzfLua oldfiles<CR>"
                                     :desc "Recently used files"
                                     :icon " "
                                     :key :r}
                                    {:action :<cmd>Lazy<CR>
                                     :desc :Plugins
                                     :icon "󰂖 "
                                     :key :p}
                                    {:action :<cmd>qa<CR>
                                     :desc "Quit Neovim"
                                     :icon "󰅚 "
                                     :key :q}]
                             :pick (fn [cmd opts]
                                     ((. (require :fzf-lua) cmd) opts))}
                    :sections [{:align :center :text [{1 header :hl :Include}]}
                               {:icon " "
                                :indent 2
                                :padding 1
                                :section :keys
                                :title :Keymaps}
                               {: dirs
                                :icon " "
                                :indent 2
                                :limit 4
                                :padding 1
                                :section :projects
                                :title :Projects}
                               {:hl :Keyword :section :startup}]}
        :image {:doc {:inline false :float (= (vim.fn.hostname) :Mac.lan)}}}}
