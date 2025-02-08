return {
  "tpope/vim-rsi",
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "gotmpl",
      },
    },
  },
  {
    "folke/noice.nvim",
    keys = {
      -- disable the default keymap that conflict with backward and forward navigation
      {
        "<c-f>",
        mode = { "i", "n", "s" },
        false,
      },
      {
        "<c-b>",
        mode = { "i", "n", "s" },
        false,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            ".git",
          },
        },
      },
      window = {
        width = 30,
        mappings = {
          ["z"] = "none",
        },
      },
    },
  },
}
