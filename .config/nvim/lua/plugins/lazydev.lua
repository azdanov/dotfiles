--- https://github.com/folke/lazydev.nvim
---@type LazySpec
return {
  "folke/lazydev.nvim",
  opts = {
    library = {
      { path = "nvim-lspconfig", words = { "lspconfig" } },
    },
  },
}
