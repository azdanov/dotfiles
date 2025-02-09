return {
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
    "MagicDuck/grug-far.nvim",
    opts = {
      headerMaxWidth = 80,
      engines = {
        astgrep = {
          path = "ast-grep",
        },
      },
    },
  },
}
