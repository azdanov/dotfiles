---@type vim.lsp.Config
return {
  ---@type lsp.gopls
  settings = {
    gopls = {
      gofumpt = true,
      semanticTokens = true,
      staticcheck = true,
      usePlaceholders = true,
      analyses = {
        -- Incorrect or missing package comment: https://staticcheck.dev/docs/checks/#ST1000
        ST1000 = false,
      },
    },
  },
}
