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
        gopls = {
          settings = {
            gopls = {
              buildFlags = { "-tags=unit integration e2e" },
            },
          },
        },
      },
    },
  },
}
