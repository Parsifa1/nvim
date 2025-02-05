[;; markdown-preview
 {1 :iamcco/markdown-preview.nvim
  :build ":cal mkdp#util#install()"
  :cmd [:MarkdownPreviewToggle :MarkdownPreview :MarkdownPreviewStop]
  :ft [:markdown]}
 ;; markdown-typmath
 {1 :parsifa1/markdown-typmath.nvim
  :config (fn []
            ((. (require :typmath) :setup)))
  :enabled false
  :ft :markdown}
 ;; render-markdown
 {1 :MeanderingProgrammer/render-markdown.nvim
  :ft [:markdown :Avante]
  :opts {:file_types [:markdown :Avante]}}]
