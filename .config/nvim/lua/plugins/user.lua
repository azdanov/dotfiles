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
      integrations = { blink_cmp = true },
      term_colors = function() return vim.g.neovide end,
    },
  },
  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
    },
  },
}
