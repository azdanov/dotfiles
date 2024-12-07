---@type LazySpec
return {
  "tpope/vim-rsi",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function(_, opts)
      opts.background = {
        light = "latte",
        dark = "macchiato",
      }
      if vim.g.neovide then opts.term_colors = true end
    end,
  },
}
