-- Disable diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx)
--   if vim.lsp.get_client_by_id(ctx.client_id) and vim.lsp.get_client_by_id(ctx.client_id).name == "vtsls" then return end
--   vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
-- end

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.vtsls
  settings = {
    typescript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = false },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
      },
      updateImportsOnFileMove = { enabled = "always" },
    },
    javascript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = false },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
      },
      updateImportsOnFileMove = { enabled = "always" },
    },
  },
}
