(fn config []
  (let [custom (require :custom)
        lspconfig (require :lspconfig)
        server (. (require :utils.server) :server)]
    (tset (. (require :lspconfig.ui.windows) :default_options) :border :rounded)

    (fn lsp-keymap [bufnr]
      (fn kset [keys func indesc]
        (vim.keymap.set :n keys func {:buffer bufnr :desc indesc}))

      ;; fnlfmt: skip
      (kset :K vim.lsp.buf.hover "LSP Hover")
      (kset :gr "<cmd>FzfLua lsp_references<CR>" "[R]eferences")
      (kset :gk vim.lsp.buf.signature_help "LSP Signature help")
      (kset :<leader>cn vim.lsp.buf.rename "[C]ode Item Re[N]ame")
      (kset :gD "<cmd>FzfLua lsp_document_symbols<CR>" "[D]oc symbols")
      (kset :gd (. (require :fzf-lua) :lsp_definitions) "[D]efinition")
      (kset :<leader>cd vim.diagnostic.open_float "[C]ode [D]iagnostic")
      (kset :gi "<cmd>FzfLua lsp_implementations<CR>" "[I]mplementations")
      (kset :<leader>ca (. (require :fastaction) :code_action) "[C]ode[A]ction")
      (kset :<leader>ct vim.lsp.buf.type_definition "[C]ode [T]ype definition"))

    (let [config vim.diagnostic.config
          ERROR vim.diagnostic.severity.ERROR
          HINT vim.diagnostic.severity.HINT
          INFO vim.diagnostic.severity.INFO
          WARN vim.diagnostic.severity.WARN]
      (config {:float {:border custom.border
                       :severity_sort true
                       :source :if_many}
               :jump {:float true}
               :severity_sort true
               :signs {:text {ERROR custom.icons.diagnostic.Error
                              HINT custom.icons.diagnostic.Hint
                              INFO custom.icons.diagnostic.Information
                              WARN custom.icons.diagnostic.Warning}}
               :virtual_text {:spacing 4}}))
    (each [lsp config (vim.iter server)]
      (set config.capabilities
           ((. (require :blink.cmp) :get_lsp_capabilities) config.capabilities))
      ((. lspconfig lsp :setup) config))
    (vim.api.nvim_create_autocmd :LspAttach
                                 {:callback (fn [args] (lsp-keymap args.buf)
                                              (local client
                                                     (vim.lsp.get_client_by_id args.data.client_id))
                                              (when (and client
                                                         client.server_capabilities.inlayHintProvider)
                                                (vim.lsp.inlay_hint.enable true)))
                                  :desc "General LSP Attach"})
    (when (= (. (vim.version) :prerelease) :dev)
      (vim.keymap.del :n :gri)
      (vim.keymap.del :n :gra)
      (vim.keymap.del :n :grn)
      (vim.keymap.del :n :grr)
      (vim.api.nvim_command :LspStart))))

[{1 :neovim/nvim-lspconfig
  :cmd :LspInfo
  : config
  :event [:BufReadPre :BufNewFile]}
 {1 :Chaitanyabsprip/fastaction.nvim :event :LspAttach :opts {}}
 {1 :kosayoda/nvim-lightbulb
  :event :LspAttach
  :opts {:autocmd {:enabled true}}}]
