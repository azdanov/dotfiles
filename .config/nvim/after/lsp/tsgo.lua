local inlayHints = {
  parameterNames = {
    enabled = "literals",
    suppressWhenArgumentMatchesName = true,
  },
  parameterTypes = { enabled = true },
  variableTypes = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  enumMemberValues = { enabled = true },
}
local preferences = {
  suggest = {
    completeFunctionCalls = true,
  },
  preferences = {
    importModuleSpecifierPreference = "non-relative",
    preferTypeOnlyAutoImports = true,
  },
  inlayHints = inlayHints,
}

---@type vim.lsp.Config
return {
  --- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md
  init_options = {
    hostInfo = "neovim",
  },
  settings = {
    completions = {
      completeFunctionCalls = true,
    },
    typescript = preferences,
    javascript = preferences,
  },
  -- https://github.com/sergiornelas/nvim/blob/main/lua/plugins/lsp/capabilities/tsgo.lua
  on_attach = function(client)
    local caps = client.server_capabilities

    -- UX / interaction
    caps.hoverProvider = false
    caps.completionProvider = false
    caps.definitionProvider = false
    caps.declarationProvider = false
    caps.implementationProvider = false
    caps.referencesProvider = false
    caps.renameProvider = false
    caps.codeActionProvider = false
    caps.signatureHelpProvider = false
    caps.documentHighlightProvider = false

    -- symbols / navegation
    caps.documentSymbolProvider = false
    caps.workspaceSymbolProvider = false

    -- format / tokens
    caps.documentFormattingProvider = false
    caps.documentRangeFormattingProvider = false
    caps.semanticTokensProvider = nil

    -- other
    caps.typeDefinitionProvider = false
    caps.callHierarchyProvider = false
    caps.selectionRangeProvider = false
    caps.inlayHintProvider = false

    -- diagnostics: no touch
    -- textDocument/publishDiagnostics don't depend on capabilities
  end,
}
