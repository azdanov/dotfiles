---@type LazySpec
return {
  "folke/ts-comments.nvim",
  opts = {},
  event = "VeryLazy",
  enabled = vim.fn.has "nvim-0.10.0" == 1,
  dependencies = {
    { "numToStr/Comment.nvim", enabled = false, optional = true },
    { "JoosepAlviste/nvim-ts-context-commentstring", enabled = false, optional = true },
  },
}
