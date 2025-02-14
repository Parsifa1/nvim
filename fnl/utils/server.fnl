(local custom (require :custom))
(local config (. (require :utils.lspconfig) :config))
(local M {:server {}})
(set M.lsp [:zls
            :html
            :volar
            :astro
            :gopls
            ; :cssls
            :taplo
            :lua_ls
            :jsonls
            :yamlls
            :marksman
            :tinymist
            :tailwindcss
            :mdx_analyzer
            :nginx_language_server
            :fennel_language_server])

(set M.tools [:prettier :stylua :ruff :typstyle :clang-format :codelldb])
(local system [:hls :nixd :clangd :pyright])
(local windows [:verible :omnisharp])
(when (= (. (vim.uv.os_uname) :sysname) :Windows_NT)
  (each [_ i (ipairs windows)] (table.insert M.lsp i)))

(custom.register M.server M.lsp config)
(custom.register M.server system config)
M
