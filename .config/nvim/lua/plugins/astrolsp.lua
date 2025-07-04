---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
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
