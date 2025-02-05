(local custom (require :custom))
{1 :hedyhli/outline.nvim
 :cmd :Outline
 :keys [{1 :<leader>o 2 :<Cmd>Outline<CR> :desc :Outline}]
 :opts {:preview_window {:border custom.border :live true}
        :symbols {:icon_source custom.icons.vsckind}}}
