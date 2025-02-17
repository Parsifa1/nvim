{1 :3rd/image.nvim
 :enabled false
 :config #(let [image (. (require :image) :setup)]
            (image {:backend :kitty
                    :integrations {:markdown {:only_render_image_at_cursor true}
                                   :typst {:only_render_image_at_cursor true}}}))
 :ft [:markdown :typst]}
