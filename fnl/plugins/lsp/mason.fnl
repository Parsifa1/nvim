[{1 :williamboman/mason.nvim
  :cmd [:Mason :MasonInstall :MasonUninstall :MasonUninstallAll :MasonUpdate]
  :config (fn []
            (local mason (. (require :mason) :setup))
            (mason {:PATH :append
                    :registries ["github:mason-org/mason-registry"
                                 "github:Crashdummyy/mason-registry"
                                 "github:Parsifa1/typstyle-mason-registry"]
                    :ui {:border :rounded
                         :backdrop 100
                         :icons {:package_installed "✓"
                                 :package_pending "➜"
                                 :package_uninstalled "✗"}}}))
  :dependencies :rcarriga/nvim-notify
  :keys [{1 :<leader>m 2 :<cmd>Mason<CR> :desc "open Mason"}]}
 {1 :WhoIsSethDaniel/mason-tool-installer.nvim
  :cmd [:MasonToolsInstall
        :MasonToolsInstallSync
        :MasonToolsUpdate
        :MasonToolsUpdateSync
        :MasonToolsClean]
  :config (fn []
            (local installed (. (require :utils.server) :tools))
            (each [_ sv (ipairs (. (require :utils.server) :lsp))]
              (table.insert installed sv))
            ((. (require :mason-tool-installer) :setup) {:ensure_installed installed}))
  :dependencies [:williamboman/mason.nvim :williamboman/mason-lspconfig.nvim]}]
