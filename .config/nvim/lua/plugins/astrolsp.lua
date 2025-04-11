---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        vtsls = {
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
          },
        },
        golangci_lint_ls = {
          cmd = { "go", "run", "github.com/nametake/golangci-lint-langserver@latest", "-debug" },
          init_options = {
            command = {
              "go",
              "run",
              "github.com/golangci/golangci-lint/cmd/golangci-lint",
              "run",
              "--out-format",
              "json",
              "--issues-exit-code=1",
            },
          },
        },
      },
    },
  },
}
