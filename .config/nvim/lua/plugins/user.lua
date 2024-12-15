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
    "zbirenbaum/copilot.lua",
    opts = {
      panel = { enabled = false },
    },
  },
  {
    "Saghen/blink.cmp",
    opts = {
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
      keymap = {
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
    },
  },
}
