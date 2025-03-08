(var show-dotfiles false)

(fn filter-dot [fs-entry]
  (fn filter-show [] true)

  (fn filter-hide [] (not (vim.startswith fs-entry.name ".")))

  (if show-dotfiles (filter-show) (filter-hide)))

(fn custom-sort [fs-entries]
  (let [res (vim.tbl_map (fn [x]
                           (let [ext (or (x.name:match ".+%.(%w+)$") "")]
                             {:fs_type x.fs_type
                              :is_dir (= x.fs_type :directory)
                              :lower_ext (ext:lower)
                              :lower_name (x.name:lower)
                              :name x.name
                              :path x.path}))
                         fs-entries)]
    (fn compare-custom [a b]
      (if (and a.is_dir (not b.is_dir)) true
          (and (not a.is_dir) b.is_dir) false
          (and a.is_dir b.is_dir) (< a.lower_name b.lower_name)
          (if (= a.lower_ext b.lower_ext) (< a.lower_name b.lower_name)
              (< a.lower_ext b.lower_ext))))

    (table.sort res compare-custom)
    (vim.tbl_map (fn [x] {:fs_type x.fs_type :name x.name :path x.path}) res)))

(fn map-split [buf-id lhs direction]
  (fn rhs []
    (var new-target-window nil)
    (vim.api.nvim_win_call (. (MiniFiles.get_explorer_state) :target_window)
                           (fn [] (vim.cmd (.. direction " split"))
                             (set new-target-window
                                  (vim.api.nvim_get_current_win))))
    (vim.defer_fn (fn [] (MiniFiles.set_target_window new-target-window)
                    (MiniFiles.go_in)
                    (MiniFiles.close))
      30))

  (local split-direction (. (vim.split direction " ") 2))
  (local desc (.. "Open in " split-direction " split"))
  (vim.keymap.set :n lhs rhs {:buffer buf-id : desc}))

(fn files-set-cwd [_]
  (let [cur-entry-path (. (MiniFiles.get_fs_entry) :path)
        cur-directory (vim.fs.dirname cur-entry-path)]
    (vim.fn.chdir cur-directory)
    (MiniFiles.open)
    (MiniFiles.reset)))

(fn command []
  (let [this (vim.api.nvim_buf_get_name 0)
        cmd (if (= (vim.fn.filereadable this) 1) MiniFiles.open MiniFiles.open)]
    (cmd)
    (MiniFiles.reveal_cwd)))

(fn init []
  (local au vim.api.nvim_create_autocmd)

  (fn go-in-plus [] (MiniFiles.go_in {:close_on_file true}))

  (au :User {:callback (fn [args]
                         (local win-id args.data.win_id)
                         (vim.api.nvim_win_set_config win-id {:border :rounded}))
             :pattern :MiniFilesWindowOpen})
  (au :User {:callback (fn [args]
                         (fn map-buf [lhs rhs]
                           (vim.keymap.set :n lhs rhs
                                           {:buffer args.data.buf_id}))

                         (fn toggle-dotfiles []
                           (set show-dotfiles (not show-dotfiles))
                           (MiniFiles.refresh {:content {:filter filter-dot}}))

                         (local buf-id args.data.buf_id)
                         (vim.keymap.set :n "." toggle-dotfiles
                                         {:buffer buf-id :desc "show dotfiles"})
                         (map-buf :L go-in-plus)
                         (map-buf :<CR> go-in-plus)
                         (map-buf :<Space> go-in-plus)
                         (map-buf :<2-LeftMouse> go-in-plus)
                         (map-buf :<Right> go-in-plus)
                         (map-buf :<Left> MiniFiles.go_out)
                         (map-buf :<Esc> MiniFiles.close)
                         (map-split buf-id :zs "belowright horizontal")
                         (map-split buf-id :zv "belowright vertical")
                         (vim.keymap.set :n "`" files-set-cwd
                                         {:buffer args.data.buf_id})
                         (vim.keymap.set [:n :i] :<C-s> MiniFiles.synchronize
                                         {:buffer args.data.buf_id}))
             :pattern :MiniFilesBufferCreate})
  (au :User {:callback (fn [event]
                         (Snacks.rename.on_rename_file event.data.from
                                                       event.data.to))
             :pattern :MiniFilesActionRename}))

[{1 :echasnovski/mini.files
  : init
  :keys [{1 :<leader>e 2 command :desc "file explorer"}]
  :opts {:content {:filter filter-dot :sort custom-sort}
         :mappings {:go_in_plus :<CR> :reveal_cwd ""}
         :options {:use_as_default_explorer true}
         :windows {:max_number math.huge
                   :width_focus 50
                   :width_nofocus 15
                   :width_preview 50}}}
 {1 :echasnovski/mini.icons
  :init (fn []
          (fn package.preload.nvim-web-devicons []
            ((. (require :mini.icons) :mock_nvim_web_devicons))
            (. package.loaded :nvim-web-devicons)))
  :opts {:file {:.tasks {:glyph "" :hl :MiniIconsGrey}
                :config {:glyph "󰒓" :hl :MiniIconsGreen}
                :devenv.lock {:glyph "" :hl :MiniIconsGrey}}
         :filetype {:moonbit {:glyph "󱩡" :hl :MiniIconsPurple}}
         :extension {:c {:glyph "󰙱" :hl :MiniIconsBlue}
                     :db {:glyph "󰆼" :hl :MiniIconsGrey}
                     :md {:glyph "󰍔" :hl :MiniIconsGrey}
                     :ts {:glyph "󰛦" :hl :MiniIconsAzure}
                     :py {:glyph "󰌠" :hl :MiniIconsYellow}
                     :js {:glyph "󰌞" :hl :MiniIconsYellow}
                     :rs {:glyph "󱘗" :hl :MiniIconsOrange}
                     :log {:glyph "󰕲" :hl :MiniIconsGrey}
                     :mdx {:glyph "󰍔" :hl :MiniIconsGrey}
                     :css {:glyph "󰌜" :hl :MiniIconsAzure}
                     :vue {:glyph "󰡄" :hl :MiniIconsGreen}
                     :age {:glyph "󰦝" :hl :MiniIconsGreen}
                     :nix {:glyph "󱄅" :hl :MiniIconsAzure}
                     :typ {:glyph "󰬛" :hl :MiniIconsAzure}
                     :lua {:glyph "󰢱" :hl :MiniIconsAzure}
                     :cpp {:glyph "󰙲" :hl :MiniIconsAzure}
                     :ini {:glyph "󰯂" :hl :MiniIconsAzure}
                     :mbt {:glyph "󱩡" :hl :MiniIconsPurple}
                     :fnl {:glyph "" :hl :MiniIconsYellow}
                     :txt {:glyph "󰦪" :hl :MiniIconsYellow}
                     :toml {:glyph "" :hl :MiniIconsOrange}
                     :astro {:glyph "" :hl :MiniIconsOrange}}}
  :specs [{1 :nvim-tree/nvim-web-devicons :enabled false :optional true}]}]
