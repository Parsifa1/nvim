(local macos {:default_im_select :com.apple.keylayout.ABC
              :default_command :macism})

(local linux {:default_im_select :keyboard-us :default_command :fcitx5-remote})

{1 :keaising/im-select.nvim
 :event "User AfterLoad"
 :enabled (not= (vim.fn.hostname) :LAPTOP-ALDRIC)
 :config #(let [setup (. (require :im_select) :setup)]
            (if (= (vim.fn.hostname) :nixos) (setup linux) (setup macos)))}
