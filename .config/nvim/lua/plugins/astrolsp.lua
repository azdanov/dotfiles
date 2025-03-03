---@type LazySpec
return {
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
    },
    file_operations = {
      operations = {
        willCreate = true,
        didCreate = true,
        willRename = true,
        didRename = true,
        willDelete = true,
        didDelete = true,
      },
    },
  },
}
