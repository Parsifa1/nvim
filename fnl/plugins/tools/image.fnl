{1 :3rd/image.nvim
 :config (fn []
           ((. (require :image) :setup) {:backend :kitty
                                         :integrations {:markdown {:only_render_image_at_cursor true}
                                                        :typst {:only_render_image_at_cursor true}}}))
 :enabled (not= (vim.fn.hostname) :debian)
 :ft [:markdown :typst]}
