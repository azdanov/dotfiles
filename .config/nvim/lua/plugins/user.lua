---@type LazySpec
return {
  "tpope/vim-rsi",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      background = {
        light = "latte",
        dark = "macchiato",
      },
      term_colors = vim.g.neovide,
    },
  },
}
