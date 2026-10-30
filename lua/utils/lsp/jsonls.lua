---@class vim.lsp.Config
return {
  -- jsonls LSP mode has no allowComments setting; filter instead.
  -- 0x209 = CommentNotPermitted, 0x207 = TrailingComma (vscode-json-languageservice ErrorCode)
  handlers = {
    ["textDocument/diagnostic"] = function(err, result, ctx)
      if result and result.items then
        local filtered = {}
        for _, d in ipairs(result.items) do
          if d.code ~= 0x209 and d.code ~= 0x207 then filtered[#filtered + 1] = d end
        end
        result.items = filtered
      end
      vim.lsp.diagnostic.on_diagnostic(err, result, ctx)
    end,
  },
}
